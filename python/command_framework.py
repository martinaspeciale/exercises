"""
Run: python command_framework.py
"""

from __future__ import annotations
import time
from typing import Any, Callable, Dict, Iterable, Optional
from functools import wraps


# --- Exceptions --------------------------------------------------------------
class UnknownCommandError(Exception):
    """Raised when a command name is not found in the registry."""
    pass

class CommandPermissionError(Exception):
    """Raised when a user does not have the required roles to run a command."""
    pass

class BadArgumentsError(Exception):
    """Raised when required arguments are missing or invalid."""
    pass

# --- Utilities ---------------------------------------------------------------
class Timer:
    """Simple timing context manager for measuring elapsed time."""
    def __enter__(self):
        self.t0 = time.perf_counter()
        return self
    def __exit__(self, exc_type, exc, tb):
        self.dt = time.perf_counter() - self.t0



# --- Core types --------------------------------------------------------------
class User:
    """Represents an authenticated user and their roles."""
    def __init__(self, name: str, roles: Iterable[str]):
        self.name = name
        self.roles = set(roles)
    def __repr__(self) -> str:
        return f"User(name={self.name!r}, roles={sorted(self.roles)!r})"

class CommandRegistry:
    """Stores command callables and their required roles."""
    def __init__(self):
        self._commands: Dict[str, Callable[..., Any]] = {}
        self._roles_required: Dict[str, set[str]] = {}

    def register(self, name: str, fn: Callable[..., Any], roles: Optional[Iterable[str]] = None) -> None:
        if name in self._commands:
            raise ValueError(f"Command '{name}' already registered.")
        self._commands[name] = fn
        self._roles_required[name] = set(roles or set())
        print(f"[reg] registered command '{name}' with roles {self._roles_required[name]}")

    def get(self, name: str) -> Callable[..., Any]:
        try:
            return self._commands[name]
        except KeyError:
            raise UnknownCommandError(f"Unknown command: {name}")

    def required_roles(self, name: str) -> set[str]:
        return set(self._roles_required.get(name, set()))

    def list(self) -> Dict[str, set[str]]:
        return {k: set(v) for k, v in self._roles_required.items()}

REGISTRY = CommandRegistry()

# --- Decorators: @command ----------------------------------------------------
def command(name: Optional[str] = None, *, roles: Optional[Iterable[str]] = None):
    """Register a function as a command with optional required roles."""
    def deco(fn: Callable[..., Any]) -> Callable[..., Any]:
        cmd_name = name or fn.__name__
        REGISTRY.register(cmd_name, fn, roles=roles)
        return fn
    return deco

# --- Decorators: @requires_args ----------------------------------------------
def requires_args(*required: str):
    """Ensure specified kwargs are present before invoking the function."""
    def deco(fn: Callable[..., Any]) -> Callable[..., Any]:
        @wraps(fn)
        def wrapper(*args, **kwargs):
            missing = [r for r in required if r not in kwargs]
            if missing:
                raise BadArgumentsError(f"Missing required arguments: {missing}")
            return fn(*args, **kwargs)
        return wrapper
    return deco

# --- Decorators: @logged -----------------------------------------------------
def logged(*, prefix: str = ""):
    """Log start and end of a function call with kwargs and elapsed time."""
    def deco(fn: Callable[..., Any]) -> Callable[..., Any]:
        @wraps(fn)
        def wrapper(*args, **kwargs):
            fname = fn.__name__
            print(f"[log] START {prefix}{fname} kwargs={kwargs}")
            with Timer() as t:
                result = fn(*args, **kwargs)
            elapsed = f"{t.dt:.3f} s"
            disp = repr(result) if isinstance(result, str) else result
            print(f"[log] END   {prefix}{fname} -> {disp} in {elapsed}")
            return result
        return wrapper
    return deco


# --- Caching -----------------------------------------------------------------
def freeze_args(args: Tuple[Any, ...], kwargs: Dict[str, Any]) -> Hashable:
    """Turn args/kwargs into a hashable key for caching."""
    return (args, tuple(sorted(kwargs.items())))

class LRUCache:
    """Small LRU cache with hit/miss stats."""
    def __init__(self, maxsize: int = 128):
        if maxsize <= 0:
            raise ValueError("maxsize must be > 0")
        self.maxsize = maxsize
        self._data: "OrderedDict[Hashable, Any]" = OrderedDict()
        self.hits = 0
        self.misses = 0
    def __len__(self) -> int:
        return len(self._data)
    def get(self, key: Hashable, default: Any = None) -> Any:
        if key in self._data:
            self._data.move_to_end(key)
            self.hits += 1
            return self._data[key]
        self.misses += 1
        return default
    def put(self, key: Hashable, value: Any) -> None:
        self._data[key] = value
        self._data.move_to_end(key)
        if len(self._data) > self.maxsize:
            self._data.popitem(last=False)
    def stats(self) -> Dict[str, Any]:
        return {"hits": self.hits, "misses": self.misses, "size": len(self._data), "capacity": self.maxsize}

def memoize(*, maxsize: int = 128):
    """LRU memoization decorator using a per-function cache."""
    cache = LRUCache(maxsize=maxsize)
    def deco(fn: Callable[..., Any]) -> Callable[..., Any]:
        @wraps(fn)
        def wrapper(*args, **kwargs):
            key = freeze_args(args, kwargs)
            if key in cache._data:
                cache.hits += 1
                print(f"[cache] HIT  {fn.__name__} key={kwargs or args}")
                cache._data.move_to_end(key)
                return cache._data[key]
            print(f"[cache] MISS {fn.__name__} key={kwargs or args}")
            value = fn(*args, **kwargs)
            cache.put(key, value)
            return value
        # Expose cache for inspection
        wrapper._lru_cache = cache  # type: ignore[attr-defined]
        return wrapper
    return deco

def main():
    # Temporary entry point for early versions
    print("Command framework — WIP")

if __name__ == "__main__":
    main()
