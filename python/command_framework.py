"""
Run: python command_framework.py
"""

from __future__ import annotations
import time
from typing import Any, Callable, Dict, Iterable, Optional


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


def main():
    # Temporary entry point for early versions
    print("Command framework — WIP")

if __name__ == "__main__":
    main()
