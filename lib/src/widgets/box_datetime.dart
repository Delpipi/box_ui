import 'dart:convert';

import 'package:get/get_connect/connect.dart';
import 'package:jiffy/jiffy.dart';

class BoxDateTime extends GetConnect {
  Future<String> getCurrentDate() async {
    var response =
        await get("http://worldtimeapi.org/api/timezone/Africa/Abidjan");
    var datetime = json.decode(response.body['datetime']);
    return Jiffy(DateTime.parse(datetime as String)).yMMMMEEEEd;
  }

  Future<String> getCurrentDateTime() async {
    var response =
        await get("http://worldtimeapi.org/api/timezone/Africa/Abidjan");
    var datetime = json.decode(response.body['datetime']);
    return Jiffy(DateTime.parse(datetime as String)).yMMMMEEEEdjm;
  }

  Future<String> getCurrentTime() async {
    var response =
        await get("http://worldtimeapi.org/api/timezone/Africa/Abidjan");
    var datetime = json.decode(response.body['datetime']);
    return Jiffy(DateTime.parse(datetime as String)).Hm;
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
