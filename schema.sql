-- Создание таблицы users
CREATE TABLE users (
    id UUID PRIMARY KEY,
    username VARCHAR(32) UNIQUE NOT NULL,
    email VARCHAR(64) UNIQUE NOT NULL,
    phone VARCHAR(32) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    salt VARCHAR(255) NOT NULL,
    name VARCHAR(32) NOT NULL,
    surname VARCHAR(32) NOT NULL,
    bio VARCHAR(255) NOT NULL,
    verification BOOLEAN NOT NULL,
    registration_date TIMESTAMP NOT NULL,
    birthday TIMESTAMP NOT NULL
);

-- Создание таблицы sparrows (посты)
CREATE TABLE sparrows (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id),
    content VARCHAR(255) NOT NULL,
    parent_id UUID NOT NULL,
    date TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Создание таблицы sparrow_images (изображения для постов)
CREATE TABLE sparrow_images (
    id UUID PRIMARY KEY,
    sparrow_id UUID NOT NULL REFERENCES sparrows(id),
    path VARCHAR(255) NOT NULL
);

-- Создание таблицы hashtags (хэштеги)
CREATE TABLE hashtags (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    amount INT NOT NULL
);

-- Создание таблицы hashtags_sparrows (связь постов и хэштегов)
CREATE TABLE hashtags_sparrows (
    hashtag_id UUID NOT NULL REFERENCES hashtags(id),
    sparrow_id UUID NOT NULL REFERENCES sparrows(id),
    PRIMARY KEY (hashtag_id, sparrow_id)
);

-- Создание таблицы likes (лайки для постов)
CREATE TABLE likes (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id),
    sparrow_id UUID NOT NULL REFERENCES sparrows(id),
    date TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Создание таблицы subscribers (подписчики)
CREATE TABLE subscribers (
    id UUID PRIMARY KEY,
    from_id UUID NOT NULL REFERENCES users(id),
    to_id UUID NOT NULL REFERENCES users(id),
    date TIMESTAMP WITH TIME ZONE NOT NULL
);

-- Создание таблицы user_images (изображения профилей пользователей)
CREATE TABLE user_images (
    id UUID PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES users(id),
    path VARCHAR(255) NOT NULL
);