import 'dart:convert';

import 'package:get/get_connect/connect.dart';
import 'package:jiffy/jiffy.dart';

class BoxDateTime extends GetConnect {
  Future<String> getCurrentDate() async {
    var response =
        await get("http://worldtimeapi.org/api/timezone/Africa/Abidjan");
    Map<String, Object?> data = json.decode(response.body);
    return Jiffy(DateTime.parse(data['datetime'] as String)).yMMMMEEEEd;
  }

  Future<String> getCurrentDateTime() async {
    var response =
        await get("http://worldtimeapi.org/api/timezone/Africa/Abidjan");
    Map<String, Object?> data = json.decode(response.body);
    return Jiffy(DateTime.parse(data['datetime'] as String)).yMMMMEEEEdjm;
  }

  Future<String> getCurrentTime() async {
    var response =
        await get("http://worldtimeapi.org/api/timezone/Africa/Abidjan");
    Map<String, Object?> data = json.decode(response.body);
    return Jiffy(DateTime.parse(data['datetime'] as String)).Hm;
  }

  Future<int> getDayOfWeek() async {
    var response =
        await get("http://worldtimeapi.org/api/timezone/Africa/Abidjan");
    var data = json.decode(response.body);
    return data['day_of_week'];
  }

  Future<int> getNumberWeek() async {
    var response =
        await get("http://worldtimeapi.org/api/timezone/Africa/Abidjan");
    var data = json.decode(response.body);
    return data['week_number'];
  }
}
