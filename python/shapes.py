from __future__ import annotations
from abc import ABC, abstractmethod
import math

class Shape(ABC):
    @abstractmethod
    def area(self) -> float:
        """Return the area of the shape."""
        raise NotImplementedError

class Circle(Shape):
    def __init__(self, radius: float) -> None:
        if radius <= 0:
            raise ValueError("Radius must be positive.")
        self.radius = float(radius)

    def area(self) -> float:
        return math.pi * self.radius ** 2

    def __repr__(self) -> str:
        return f"Circle(radius={self.radius})"

class Rectangle(Shape):
    def __init__(self, width: float, height: float) -> None:
        if width <= 0 or height <= 0:
            raise ValueError("Width and height must be positive.")
        self.width = float(width)
        self.height = float(height)

    def area(self) -> float:
        return self.width * self.height

    def __repr__(self) -> str:
        return f"Rectangle(width={self.width}, height={self.height})"


if __name__ == "__main__":
    shapes: list[Shape] = [Circle(3), Rectangle(4, 5)]
    for s in shapes:
        print(f"{s!r} area = {s.area():.2f}")

