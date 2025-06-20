import time
from datetime import datetime 

def timing(f):
    def wrapper(*args, **kwargs):
        start = time.time()
        result = f(*args, **kwargs)
        end = time.time()
        print(f"{f.__name__} took {end-start:.2f} seconds")
        return result
    return wrapper 


def hash_pword(password):
    return hashlib.sha256(password.encode()).hexdigest()
current_year = time.localtime().tm_year


class User:
    def __init__(self, username, password):
        if not isinstance(username, str):
            raise TypeError("username must be a string")
        if not isinstance(password, str):
            raise TypeError("password must be a string")
        
        self.username = username 
        self.password = password 

    def __str__(self):
        return f"Hi {self.username}!"
    
class Content:
    def __init__(self, title, year):
        if not isinstance(year, int):
            raise TypeError("year must be an integer")
        if not isinstance(title, str):
            raise TypeError("title must be a string")
        
        if year < 1900 or year > datetime.now().year:
            raise TypeError("check your year!")
        
        self.title = title 
        self.year = year
        
    
    def __str__(self):
        return f"{self.title} ({self.year})"


class TVShow(Content):
        def __init__(self, title, year, seasons):
            if not isinstance(seasons, int):
                raise TypeError("#seasons must be an integer")
            if seasons < 0 or seasons > 25:
                raise TypeError("think you should check your #seasons!")

            super().__init__(title, year)
            self.seasons = seasons 
        
        def __str__(self):
            content_str = super().__str__() 
            return f"{content_str} - {self.seasons} seasons"

class Movie(Content):
        def __init__(self, title, year, director):
            if not isinstance(director, str):
                raise TypeError("director must be a string")
            super().__init__(title, year)
            self.director = director 
        
        def __str__(self):
            content_str = super().__str__()
            return f"{content_str} - directed by: {self.director}"


if __name__ == "__main__":
    tv_title = input("enter tv show: ")
    tv_year = int(input("enter year: "))
    tv_seasons = int(input("enter number of seasons: "))


    tv_show = TVShow(tv_title, tv_year, tv_seasons)
    print(tv_show)

    movie_title = input("enter movie: ")
    movie_year = int(input("enter year: "))
    movie_director = input("who is the director: ")

    movie = Movie(movie_title, movie_year, movie_director)
    print(movie)