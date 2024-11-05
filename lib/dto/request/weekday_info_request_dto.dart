import 'package:foody_app/utils/sitting_times_steps.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../utils/time_json_serializer.dart';

part '../mapper/request/weekday_info_request_dto.g.dart';

@JsonSerializable()
class WeekdayInfoRequestDto {
  const WeekdayInfoRequestDto({
    required this.weekDay,
    required this.startLaunch,
    required this.endLaunch,
    required this.startDinner,
    required this.endDinner,
    required this.sittingTimeStep,
  });

  factory WeekdayInfoRequestDto.fromJson(Map<String, dynamic> json) =>
      _$WeekdayInfoRequestDtoFromJson(json);

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

  Map<String, dynamic> toJson() => _$WeekdayInfoRequestDtoToJson(this);
}
