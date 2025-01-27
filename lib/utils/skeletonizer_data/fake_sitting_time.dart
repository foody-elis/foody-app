import 'package:foody_api_client/dto/response/sitting_time_response_dto.dart';

SittingTimeResponseDto getFakeSittingTime() => SittingTimeResponseDto(
      id: 0,
      start: DateTime.now(),
      end: DateTime.now(),
      weekDayInfoId: 0,
    );
