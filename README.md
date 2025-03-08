# java-explore-with-me-plus
Template repository for ExploreWithMe project.

---

## Комментарии
Комментарии реализованы на примере TripAdvisor.

```mermaid
erDiagram
    comments {
        bigint id PK
        bigint event_id FK
        bigint author_id FK
        string(120) title
        string(2000) text
        float rate
        datetime created_on
        datetime updated_on "Nullable"
    }
```

### Доступные эндпоинты
#### Public

1. GET ```/events/{eventId}/comments``` - Просмотр комментариев на событии
  - Если событие не найдено, возвращает ошибку 404
  - Событие должно быть опубликовано
    
Параметры:

  - eventId - Id события, к которому нужно вернуть комментарии
  - from - Количество коментариев, которые нужно пропустить для форматирования текущего набора. Default value: 0
  - size - Количество коментариев в наборе. Default value: 10

Статусы ответов:

  - 200 OK + тело ответа в формате CommentDto
  - 400 Bad Request + тело ответа в формате ApiError
  - 404 Not Found + тело ответа в формате ApiError
