import 'package:box_ui/src/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

class BoxDateTimeField extends StatelessWidget {
  final String? formControlName;
  final FormControl<DateTime>? formControl;
  final Map<String, ValidationMessageFunction>? validationMessages;
  final String placeholder;
  final Widget? leading;
  final Widget? trailing;
  final ReactiveDatePickerFieldType type;
  final void Function()? trailingTapped;

  final circularBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  );

  BoxDateTimeField.date({
    Key? key,
    this.formControlName,
    this.formControl,
    this.validationMessages,
    this.placeholder = '',
    this.leading,
    this.trailing,
    this.trailingTapped,
    this.type = ReactiveDatePickerFieldType.date,
  }) : super(key: key);

  BoxDateTimeField.time({
    Key? key,
    this.formControlName,
    this.formControl,
    this.validationMessages,
    this.placeholder = '',
    this.leading,
    this.trailing,
    this.trailingTapped,
    this.type = ReactiveDatePickerFieldType.time,
  }) : super(key: key);

  BoxDateTimeField.dateTime({
    Key? key,
    this.formControlName,
    this.formControl,
    this.validationMessages,
    this.placeholder = '',
    this.leading,
    this.trailing,
    this.trailingTapped,
    this.type = ReactiveDatePickerFieldType.dateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReactiveDateTimePicker(
      formControlName: formControlName,
      formControl: formControl,
      type: type,
      decoration: InputDecoration(
        labelText: placeholder,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        filled: true,
        fillColor: kcVeryLightGreyColor,
        prefixIcon: leading,
        suffixIcon: trailing != null
            ? GestureDetector(
                onTap: trailingTapped,
                child: trailing,
              )
            : null,
        border: circularBorder.copyWith(
          borderSide: const BorderSide(color: kcLightGreyColor),
        ),
        errorBorder: circularBorder.copyWith(
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedBorder: circularBorder.copyWith(
          borderSide: const BorderSide(color: kcPrimaryColor),
        ),
        enabledBorder: circularBorder.copyWith(
          borderSide: const BorderSide(color: kcLightGreyColor),
        ),
      ),
    );
  }
}
