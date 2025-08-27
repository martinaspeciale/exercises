from __future__ import annotations

class Book:
    """Book with checkout/return state."""

    def __init__(self, title: str, author: str) -> None:
        self.title = title
        self.author = author
        self.is_checked_out = False

    def checkout(self) -> None:
        if self.is_checked_out:
            raise RuntimeError(f"'{self.title}' is already checked out.")
        self.is_checked_out = True

    def return_book(self) -> None:
        if not self.is_checked_out:
            raise RuntimeError(f"'{self.title}' is not checked out.")
        self.is_checked_out = False

    def info(self) -> str:
        status = "Checked out" if self.is_checked_out else "Available"
        return f"'{self.title}' by {self.author} — {status}"

    def __repr__(self) -> str:
        return f"Book(title={self.title!r}, author={self.author!r}, 
is_checked_out={self.is_checked_out})"


if __name__ == "__main__":
    b = Book("Clean Code", "Robert C. Martin")
    print(b.info())
    b.checkout()
    print(b.info())
    b.return_book()
    print(b.info())

