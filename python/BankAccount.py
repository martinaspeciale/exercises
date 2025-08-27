from __future__ import annotations

class BankAccount:
    """Simple bank account with deposit/withdraw and balance display."""

    def __init__(self, owner: str, balance: float = 0.0) -> None:
        if balance < 0:
            raise ValueError("Initial balance cannot be negative.")
        self.owner = owner
        self._balance = float(balance)

    @property
    def balance(self) -> float:
        return self._balance

    def deposit(self, amount: float) -> None:
        if amount <= 0:
            raise ValueError("Deposit amount must be positive.")
        self._balance += amount

    def withdraw(self, amount: float) -> None:
        if amount <= 0:
            raise ValueError("Withdrawal amount must be positive.")
        if amount > self._balance:
            raise ValueError("Insufficient funds.")
        self._balance -= amount

    def display_balance(self) -> str:
        return f"{self.owner}'s balance: {self._balance:.2f}"

    def __repr__(self) -> str:  # helpful for debugging
        return f"BankAccount(owner={self.owner!r}, balance={self._balance:.2f})"


if __name__ == "__main__":
    acc = BankAccount("Alice", 100)
    acc.deposit(50)
    try:
        acc.withdraw(200)
    except ValueError as e:
        print("Withdraw failed:", e)
    acc.withdraw(75)
    print(acc.display_balance())  # Alice's balance: 75.00
