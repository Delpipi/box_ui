import 'package:box_ui/src/widgets/box_input_field/contact_controller.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

class PhoneNumber extends ControlValueAccessor<PhoneNumber, String> {
  String? countryISOCode;
  String? countryCode;
  String? number;

  PhoneNumber({
    this.countryISOCode,
    this.countryCode,
    this.number,
  });

  String get completeNumber {
    return countryCode != null ? countryCode! + number! : number!;
  }

  @override
  String toString() =>
      'PhoneNumber(countryISOCode: $countryISOCode, countryCode: $countryCode, number: $number)';

  @override
  String? modelToViewValue(PhoneNumber? modelValue) {
    //print("Reactive convert model to ViewValue: $modelValue");
    if (modelValue != null) {
      Get.find<ContactController>().setSelectedCountry(modelValue.countryCode!);
      return modelValue.number!;
    } else {
      return '';
    }
  }

  @override
  PhoneNumber? viewToModelValue(String? viewValue) {
    //print("Reactive convert view value to model: $viewValue");
    if (viewValue == '' || viewValue == null) {
      return null;
    } else {
      var selectedCountry = Get.find<ContactController>().selectedCountry.value;
      return PhoneNumber(
          countryISOCode: selectedCountry.code,
          countryCode: selectedCountry.dialCode,
          number: viewValue);
    }
  }
}
