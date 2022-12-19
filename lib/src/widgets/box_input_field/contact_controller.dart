// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';

import 'countries.dart';

class ContactController extends GetxController {
  late List<Country> countryList;
  Rx<Country> selectedCountry = Country(
    name: "Afghanistan",
    flag: "🇦🇫",
    code: "AF",
    dialCode: "93",
    minLength: 9,
    maxLength: 9,
  ).obs;
  var number = ''.obs;
  Rx<String?> errorMessage = ''.obs;

  @override
  void onInit() {
    initializeContact();
    super.onInit();
  }

  void initializeContact() {
    countryList = countries;
  }

  void setSelectedCountry(String dialCode) {
    selectedCountry.value =
        countries.firstWhere((country) => country.dialCode.contains(dialCode));
  }

  void onValueChange(String value) {
    errorMessage.value = value.length >= selectedCountry.value.minLength &&
            value.length <= selectedCountry.value.maxLength
        ? null
        : "Invalide";
  }
}
