from __future__ import annotations
from abc import ABC, abstractmethod

class Animal(ABC):
    @abstractmethod
    def speak(self) -> str:
        """Return the sound this animal makes."""
        raise NotImplementedError

class Dog(Animal):
    def speak(self) -> str:
        return "Woof!"

class Cat(Animal):
    def speak(self) -> str:
        return "Meow!"

class Cow(Animal):
    def speak(self) -> str:
        return "Moo!"

def make_it_talk(animal: Animal) -> str:
    """Polymorphic function that works for any Animal."""
    return animal.speak()


if __name__ == "__main__":
    zoo: list[Animal] = [Dog(), Cat(), Cow()]
    for a in zoo:
        print(type(a).__name__, "says:", make_it_talk(a))

