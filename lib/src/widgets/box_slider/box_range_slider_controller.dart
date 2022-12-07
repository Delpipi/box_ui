import 'package:get/get.dart';

class BoxRangeSliderController extends GetxController {
  var min = RxDouble(0.0);
  var max = RxDouble(0.0);

  void initialise(double minimum, double maximum) {
    min.value = minimum;
    max.value = maximum;
  }
}
