import 'package:dio/dio.dart';
import 'package:foody_app/repository/interface/auth_api_repository.dart';
import 'package:foody_app/repository/interface/bookings_api_repository.dart';
import 'package:foody_app/repository/interface/categories_api_repository.dart';
import 'package:foody_app/repository/interface/dishes_api_repository.dart';
import 'package:foody_app/repository/interface/restaurants_api_repository.dart';
import 'package:foody_app/repository/interface/sitting_times_api_repository.dart';
import 'package:foody_app/repository/interface/weekdays_api_repository.dart';

class FoodyApiRepository {
  final AuthApiRepository auth;
  final CategoriesApiRepository categories;
  final RestaurantsApiRepository restaurants;
  final WeekdaysApiRepository weekdays;
  final SittingTimesApiRepository sittingTimes;
  final BookingsApiRepository bookings;
  final DishesApiRepository dishes;

  FoodyApiRepository({required Dio dio})
      : auth = AuthApiRepository(dio, baseUrl: "${dio.options.baseUrl}/auth"),
        categories = CategoriesApiRepository(dio, baseUrl: "${dio.options.baseUrl}/categories"),
        restaurants = RestaurantsApiRepository(dio, baseUrl: "${dio.options.baseUrl}/restaurants"),
        weekdays = WeekdaysApiRepository(dio),
        sittingTimes = SittingTimesApiRepository(dio, baseUrl: "${dio.options.baseUrl}/sitting-times"),
        bookings = BookingsApiRepository(dio, baseUrl: "${dio.options.baseUrl}/bookings"),
        dishes = DishesApiRepository(dio, baseUrl: "${dio.options.baseUrl}/dishes");
}
