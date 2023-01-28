import 'dart:convert';

import 'package:get/get_connect/connect.dart';
import 'package:jiffy/jiffy.dart';

class BoxDateTime extends GetConnect {
  Future<String> getCurrentDate() async {
    var response =
        await get("http://worldtimeapi.org/api/timezone/Africa/Abidjan");
    var datetime = response.body['datetime'];
    return Jiffy(datetime).yMMMMEEEEd;
  }

  Future<String> getCurrentDateTime() async {
    var response =
        await get("http://worldtimeapi.org/api/timezone/Africa/Abidjan");
    var datetime = response.body['datetime'];
    return Jiffy(datetime).yMMMMEEEEdjm;
  }

  Future<String> getCurrentTime() async {
    var response =
        await get("http://worldtimeapi.org/api/timezone/Africa/Abidjan");
    var datetime = response.body['datetime'];
    return Jiffy(datetime).Hm;
  }

  Future<int> getDayOfWeek() async {
    var response =
        await get("http://worldtimeapi.org/api/timezone/Africa/Abidjan");
    return response.body['day_of_week'] as int;
  }

  Future<int> getNumberWeek() async {
    var response =
        await get("http://worldtimeapi.org/api/timezone/Africa/Abidjan");
    return response.body['week_number'] as int;
  }
}
