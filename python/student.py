from __future__ import annotations

class Student:
    """Student with simple grade calculation."""

    def __init__(self, name: str, roll_number: int, marks: float) -> None:
        if not (0 <= marks <= 100):
            raise ValueError("Marks must be between 0 and 100.")
        self.name = name
        self.roll_number = int(roll_number)
        self.marks = float(marks)

    def calculate_grade(self) -> str:
        m = self.marks
        if m >= 85:
            return "A"
        elif m >= 70:
            return "B"
        elif m >= 55:
            return "C"
        elif m >= 40:
            return "D"
        else:
            return "F"

    def info(self) -> str:
        return f"Student(name={self.name}, roll={self.roll_number}, 
marks={self.marks:.1f}, grade={self.calculate_grade()})"

    def __repr__(self) -> str:
        return f"Student({self.name!r}, {self.roll_number}, {self.marks})"


if __name__ == "__main__":
    s = Student("Marco", 101, 78.5)
    print(s.info())  # grade B

