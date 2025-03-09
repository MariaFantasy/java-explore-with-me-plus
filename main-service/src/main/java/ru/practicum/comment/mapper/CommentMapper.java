package ru.practicum.comment.mapper;

//import org.mapstruct.Mapper;
import ru.practicum.comment.dto.CommentDto;
import ru.practicum.comment.dto.NewCommentDto;
import ru.practicum.comment.model.Comment;

import java.util.List;

//@Mapper(componentModel = "spring")
public interface CommentMapper {
    CommentDto mapToDto(Comment comment);

    Comment mapFromDto(NewCommentDto commentDto);

    List<CommentDto> mapToDtoList(List<Comment> comments);
}
