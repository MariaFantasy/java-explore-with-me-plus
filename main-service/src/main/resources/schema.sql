CREATE TABLE IF NOT EXISTS users (
    id BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    email VARCHAR(254) UNIQUE NOT NULL,
    name VARCHAR(250) NOT NULL
    );

CREATE TABLE IF NOT EXISTS compilations (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY UNIQUE,
    pinned BOOLEAN NOT NULL,
    title VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS categories (
    id BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS locations (
    id BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    lat FLOAT NOT NULL,
    lon FLOAT NOT NULL
);

CREATE TABLE IF NOT EXISTS events (
    id BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    initiator_id BIGINT NOT NULL,
    title VARCHAR(120) NOT NULL,
    annotation VARCHAR(2000) NOT NULL,
    description VARCHAR(7000) NOT NULL,
    category_id BIGINT NOT NULL,
    location_id BIGINT NOT NULL,
    event_date TIMESTAMP NOT NULL,
    paid BOOLEAN NOT NULL DEFAULT false,
    request_moderation BOOLEAN NOT NULL DEFAULT false,
    participant_limit BIGINT NOT NULL DEFAULT 0,
    confirmedRequests BIGINT NOT NULL DEFAULT 0,
    state VARCHAR(50) NOT NULL,
    created_on TIMESTAMP NOT NULL,
    published_on TIMESTAMP,
    FOREIGN KEY (initiator_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(id),
    FOREIGN KEY (location_id) REFERENCES locations(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS requests (
    id BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    event_id BIGINT NOT NULL,
    requester_id BIGINT NOT NULL,
    status VARCHAR(50) NOT NULL,
    created TIMESTAMP NOT NULL,
    FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE,
    FOREIGN KEY (requester_id) REFERENCES users(id) ON DELETE CASCADE,
    CONSTRAINT unique_request UNIQUE (event_id, requester_id)
);

CREATE TABLE IF NOT EXISTS comments (
    id BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    event_id BIGINT NOT NULL,
    author_id BIGINT NOT NULL,
    title VARCHAR(120) NOT NULL,
    text VARCHAR(2000) NOT NULL,
    created_on TIMESTAMP NOT NULL,
    updated_on TIMESTAMP,
    FOREIGN KEY (event_id) REFERENCES events(id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES users(id) ON DELETE CASCADE
);