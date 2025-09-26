"""
Run: python command_framework.py
"""

from __future__ import annotations
import time

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

def main():
    # Temporary entry point for early versions
    print("Command framework — WIP")

if __name__ == "__main__":
    main()
