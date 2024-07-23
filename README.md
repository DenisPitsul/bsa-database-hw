```mermaid
erDiagram
    app_user {
        int id PK
        string username
        string first_name
        string last_name
        string email
        string password
        int avatar_file_id FK
    }
    app_file {
        int id PK
        string file_name
        string mime_type
        string key
        string url
    }
    genre {
        int id PK
        string name
    }
    movie {
        int id PK
        string title
        text description
        decimal budget
        date release_date
        int duration_minutes
        int director_id FK
        int country_id FK
        int poster_file_id FK
        int genre_id FK
    }
    character {
        int id PK
        string name
        text description
        enum role
        int movie_id FK
        int actor_id FK
    }
    actor {
        int id
        string first_name
        string last_name
        text biography
        date date_of_birth
        enum gender
        int main_photo_file_id
    }
    director {
        int id PK
        string first_name
        string last_name
        text biography
        date date_of_birth
        enum gender
        int main_photo_file_id FK
    }
    country {
        int id PK
        string name
    }
    person {
        int id PK
        string first_name
        string last_name
        text biography
        date date_of_birth
        enum gender
        int main_photo_file_id FK
    }
    favorite_movies {
        int id FK
        int movie_id FK
    }

    app_file ||--o{ app_user : has
    app_user ||--o{ favorite_movies : marks_as_favorite
    country ||--o{ movie : lives
    app_file ||--o{ person : has
    app_file ||--o{ movie : has
    app_file ||--o{ actor : has
    app_file ||--o{ director : has
    director ||--o{ movie : make
    movie ||--o{ character : includes
    genre ||--o{ movie : is
    actor ||--o{ character : plays
    movie ||--o{ favorite_movies : favorite
```