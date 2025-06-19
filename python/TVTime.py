import sqlite3
import hashlib
from time import sleep

# ------------------------
# PASSWORD HASHING
# ------------------------
def hash_password(password):
    return hashlib.sha256(password.encode()).hexdigest()

# ------------------------
# CLASSES
# ------------------------
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

class TVShow: 
    def __init__(self, title, year, seasons):
        self.title = title 
        self.year = year 
        self.seasons = seasons 
    
    def __str__(self):
        return f"{self.title} ({self.year}) - {self.seasons} seasons"

class TVTime: 
    def __init__(self, user):
        self.user = user 
        self.watched = []
        self.to_watch = []
    
    def add_watched(self, show):
        if show not in self.watched:
            self.watched.append(show)
            print(f"Watched: {show.title}")

    def add_to_watch(self, show):
        if show not in self.to_watch:
            self.to_watch.append(show)
            print(f"Added to list to watch: {show.title}")
    
    def __str__(self):
        watched_titles = '\n'.join(show.title for show in self.watched)
        titles_to_watch = '\n'.join(show.title for show in self.to_watch)
        return (f"{self.user}\n"
                f"Watched:\n{watched_titles}\n"
                f"What to watch next:\n{titles_to_watch}")

# ------------------------
# DATABASE FUNCTIONS
# ------------------------
def register_user(username, password):
    hashed_password = hash_password(password)
    conn = sqlite3.connect("tvtime.db")
    cursor = conn.cursor()
    try:
        cursor.execute("INSERT INTO users (username, password) VALUES (?, ?)", (username, hashed_password))
        conn.commit()
        print("User registered successfully.")
    except sqlite3.IntegrityError:
        print("Username already exists.")
    conn.close()

def login_user(username, password):
    hashed_password = hash_password(password)
    conn = sqlite3.connect("tvtime.db") 
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM users WHERE username = ? AND password = ?", (username, hashed_password))
    result = cursor.fetchone()
    conn.close() 

    if result:
        print("Login successful!")
        return True 
    else:
        print("Invalid username or password.")
        return False 

# ------------------------
# TV SHOW ADDING FUNCTION
# ------------------------
def add_show():
    title = input("Title: ")
    year = input("Year: ") 
    seasons = input("Number of seasons: ")
    tv_show = TVShow(title, year, seasons) 
    return tv_show 

# ------------------------
# MAIN PROGRAM
# ------------------------
if __name__ == "__main__":

    # Create the database if it doesn't exist
    conn = sqlite3.connect("tvtime.db")
    cursor = conn.cursor()
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT UNIQUE NOT NULL,
            password TEXT NOT NULL 
        );
    """)
    conn.commit()
    conn.close()

    while True: 
        print("Welcome to TVTime!")
        sleep(1)
        print("...")
        choice = input('''
Select an option:
    1. Login
    2. Sign up
    3. Exit
> ''')

        match choice:
            case "1":
                username = input("Username: ")
                password = input("Password: ")
                if login_user(username, password):
                    user = User(username, password)
                    tvtime = TVTime(user)
                    
                    # Small TVTime menu after login
                    while True:
                        print("\nWhat do you want to do?")
                        sub_choice = input('''
    1. Add watched show
    2. Add show to watchlist
    3. Show my TVTime
    4. Logout
> ''')
                        match sub_choice:
                            case "1":
                                show = add_show()
                                tvtime.add_watched(show)
                            case "2":
                                show = add_show()
                                tvtime.add_to_watch(show)
                            case "3":
                                print(tvtime)
                            case "4":
                                print("Logged out.\n")
                                break
                            case _:
                                print("Invalid choice.")
            case "2":
                username = input("Choose a username: ")
                password = input("Choose a password: ")
                register_user(username, password)
            case "3":
                print("Goodbye!")
                break
            case _:
                print("Invalid choice, please select 1, 2 or 3.")
