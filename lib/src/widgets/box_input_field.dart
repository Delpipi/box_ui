import 'package:box_ui/src/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class BoxInputField extends StatelessWidget {
  final String? formControlName;
  final FormControl<dynamic>? formControl;
  final Map<String, ValidationMessageFunction>? validationMessages;
  final String placeholder;
  final Widget? leading;
  final Widget? trailing;
  final bool password;
  final void Function()? trailingTapped;

  final circularBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  );

  BoxInputField({
    Key? key,
    this.formControlName,
    this.formControl,
    this.validationMessages,
    this.placeholder = '',
    this.leading,
    this.trailing,
    this.trailingTapped,
    this.password = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      /// Overriding the default blue color.
      ///
      /// We can also avoid this by changing the [primarySwatch] in MaterialApp
      data: ThemeData(primaryColor: kcPrimaryColor),
      child: ReactiveTextField(
        formControlName: formControlName,
        formControl: formControl,
        validationMessages: validationMessages,
        style: const TextStyle(height: 1),
        obscureText: password,
        decoration: InputDecoration(
          hintText: placeholder,
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
      ),
    );
  }
}
