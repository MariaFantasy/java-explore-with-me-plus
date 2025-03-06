package ru.practicum.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import ru.practicum.CreateHitDto;
import ru.practicum.ResponseStatsDto;
import ru.practicum.ResponseHitDto;
import ru.practicum.exception.ValidationException;
import ru.practicum.mapper.HitMapper;
import ru.practicum.model.Hit;
import ru.practicum.reposirory.StatisticRepository;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class StatisticServiceImpl implements StatisticService {

    private final StatisticRepository statisticRepository;

    @Override
    public ResponseHitDto create(CreateHitDto createHitDto) {
        final Hit hit = HitMapper.mapToHit(createHitDto);
        final Hit createdHit = statisticRepository.save(hit);
        return HitMapper.mapToResponseDto(createdHit);
    }

    @Override
    public List<ResponseStatsDto> get(String start, String end, List<String> uris, Boolean unique) {
        if (start == null || end == null) {
            throw new ValidationException("You need to chose start and end dates.");
        }
        final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        final LocalDateTime startDateTime = LocalDateTime.parse(start, formatter);
        final LocalDateTime endDateTime = LocalDateTime.parse(end, formatter);

        if (start.compareTo(end) > 0) {
            throw new ValidationException("Дата начала должна быть раньше даты окончания.");
        }

        final List<StatisticRepository.ResponseStatsDto> hits;
        if (uris.isEmpty()) {
            hits = statisticRepository.getByAllUris(startDateTime, endDateTime);
        } else {
            hits = statisticRepository.getByUris(startDateTime, endDateTime, uris);
        }
        return hits.stream()
                .map(stats -> ResponseStatsDto.builder()
                        .app(stats.getApp())
                        .uri(stats.getUri())
                        .hits(unique ? stats.getUniqHits() : stats.getHits())
                        .build()
                )
                .collect(Collectors.toCollection(ArrayList::new));
    }
}
