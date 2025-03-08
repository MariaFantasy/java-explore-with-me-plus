package ru.practicum.comment.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import ru.practicum.comment.service.CommentService;

@RestController
@RequestMapping("/users/{userId}/comments")
@Slf4j
@RequiredArgsConstructor
public class PrivateCommentController {
    public final CommentService commentService;
}
