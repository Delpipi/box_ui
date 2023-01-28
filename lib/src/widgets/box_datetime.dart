import 'package:get/get_connect/connect.dart';
import 'package:intl/intl.dart';

class BoxDateTime extends GetConnect {
  final String? lang;
  BoxDateTime({this.lang});
  Future<String?> getCurrentDate() async {
    var response =
        await get("http://worldtimeapi.org/api/timezone/Africa/Abidjan");
    if (response.body != null) {
      var datetime = response.body['datetime'];
      return DateFormat.yMMMMEEEEd(lang).format(datetime as DateTime);
    } else {
      return null;
    }
  }

  Future<String?> getCurrentDateTime() async {
    var response =
        await get("http://worldtimeapi.org/api/timezone/Africa/Abidjan");
    if (response.body != null) {
      var datetime = response.body['datetime'];
      return DateFormat.yMMMMEEEEd(lang).add_jms().format(datetime as DateTime);
    } else {
      return null;
    }
  }

  Future<String?> getCurrentTime() async {
    var response =
        await get("http://worldtimeapi.org/api/timezone/Africa/Abidjan");
    if (response.body != null) {
      var datetime = response.body['datetime'];
      return DateFormat.Hm(lang).format(datetime as DateTime);
    } else {
      return null;
    }
  }

  Future<int?> getDayOfWeek() async {
    var response =
        await get("http://worldtimeapi.org/api/timezone/Africa/Abidjan");
    if (response.body != null) {
      return response.body['day_of_week'] as int;
    } else {
      return null;
    }
  }

  Future<int?> getNumberWeek() async {
    var response =
        await get("http://worldtimeapi.org/api/timezone/Africa/Abidjan");
    if (response.body != null) {
      return response.body['week_number'] as int;
    } else {
      return null;
    }
  }
}
