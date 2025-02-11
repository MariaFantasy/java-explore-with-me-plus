CREATE TABLE IF NOT EXISTS hit (
    id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    app VARCHAR(555) NOT NULL,
    uri VARCHAR(25) NOT NULL,
    ip VARCHAR(25) NOT NULL,
    timestamp TIMESTAMP WITHOUT TIME ZONE);