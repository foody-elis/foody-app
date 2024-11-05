import 'package:foody_app/utils/sitting_times_steps.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../utils/time_json_serializer.dart';

part '../mapper/response/weekday_info_response_dto.g.dart';

@JsonSerializable()
class WeekdayInfoResponseDto {
  const WeekdayInfoResponseDto({
    required this.id,
    required this.weekDay,
    required this.startLaunch,
    required this.endLaunch,
    required this.startDinner,
    required this.endDinner,
    required this.sittingTimeStep,
    required this.restaurantId,
  });

  factory WeekdayInfoResponseDto.fromJson(Map<String, dynamic> json) =>
      _$WeekdayInfoResponseDtoFromJson(json);

  final int id;
  final int weekDay;

  @JsonKey(fromJson: timeFromJson, toJson: timeToJson)
  final DateTime startLaunch;

  @JsonKey(fromJson: timeFromJson, toJson: timeToJson)
  final DateTime endLaunch;

  @JsonKey(fromJson: timeFromJson, toJson: timeToJson)
  final DateTime startDinner;

  @JsonKey(fromJson: timeFromJson, toJson: timeToJson)
  final DateTime endDinner;

  final SittingTimeStep sittingTimeStep;

  final int restaurantId;

  Map<String, dynamic> toJson() => _$WeekdayInfoResponseDtoToJson(this);
}
