import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';
import 'package:flutter/services.dart';

class BoxInputField extends StatelessWidget {
  final String? formControlName;
  final FormControl<dynamic>? formControl;
  final TextEditingController? controller;
  final Map<String, ValidationMessageFunction>? validationMessages;
  final ShowErrorsFunction<dynamic>? showErrors;
  final String placeholder;
  final Widget? leading;
  final Widget? trailing;
  final bool password;
  final void Function()? trailingTapped;
  final int? type;

  final circularBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  );

  BoxInputField({
    Key? key,
    this.formControlName,
    this.formControl,
    this.controller,
    this.validationMessages,
    this.placeholder = '',
    this.leading,
    this.trailing,
    this.trailingTapped,
    this.password = false,
    this.showErrors,
  })  : type = 0,
        super(key: key);

  BoxInputField.contact({
    Key? key,
    this.formControlName,
    this.formControl,
    this.validationMessages,
    this.placeholder = '',
    this.leading,
    this.trailing,
    this.trailingTapped,
    this.showErrors,
  })  : type = 1,
        password = false,
        controller = null,
        super(key: key);

  BoxInputField.imagePicker({
    Key? key,
    this.formControlName,
    this.formControl,
    this.validationMessages,
    this.placeholder = '',
    this.leading,
    this.trailing,
    this.trailingTapped,
    this.showErrors,
  })  : type = 2,
        password = false,
        controller = null,
        super(key: key);

  BoxInputField.textArea({
    Key? key,
    this.formControlName,
    this.formControl,
    this.controller,
    this.validationMessages,
    this.placeholder = '',
    this.leading,
    this.trailing,
    this.trailingTapped,
    this.showErrors,
  })  : type = 3,
        password = false,
        super(key: key);

  BoxInputField.number({
    Key? key,
    this.formControlName,
    this.formControl,
    this.controller,
    this.validationMessages,
    this.placeholder = '',
    this.leading,
    this.trailing,
    this.trailingTapped,
    this.showErrors,
  })  : type = 4,
        password = false,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final boxDecoration = InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      hintText: placeholder,
      labelText: placeholder,
      filled: true,
      fillColor: kcVeryLightGreyColor,
      prefixIcon: leading,
      suffixIcon: trailing != null
          ? InkWell(
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
    );
    switch (type) {
      case 0:
        return ReactiveTextField(
          formControlName: formControlName,
          formControl: formControl,
          controller: controller,
          validationMessages: validationMessages,
          showErrors: showErrors,
          style: const TextStyle(height: 1),
          obscureText: password,
          decoration: boxDecoration,
        );
      case 1:
        return ReactivePhoneFormField<PhoneNumber>(
          formControlName: formControlName,
          formControl: formControl as FormControl<PhoneNumber>,
          validationMessages: validationMessages,
          showErrors: showErrors,
          defaultCountry: IsoCode.CI,
          decoration: boxDecoration,
        );
      case 2:
        return ReactiveImagePicker(
          formControlName: formControlName,
          formControl: formControl as FormControl<ImageFile>,
          showErrors: showErrors,
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.zero,
              labelText: 'Image',
              filled: false,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              helperText: ''),
          inputBuilder: (onPressed) => TextButton.icon(
            onPressed: onPressed,
            icon: const Icon(Icons.camera_alt),
            label: Text(placeholder),
          ),
        );
      case 3:
        return ReactiveTextField(
          formControlName: formControlName,
          formControl: formControl,
          controller: controller,
          validationMessages: validationMessages,
          showErrors: showErrors,
          style: const TextStyle(height: 1),
          maxLines: 5,
          decoration: boxDecoration,
        );
      case 4:
        return ReactiveTextField(
          formControlName: formControlName,
          formControl: formControl,
          controller: controller,
          validationMessages: validationMessages,
          showErrors: showErrors,
          style: const TextStyle(height: 1),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: boxDecoration,
        );
      default:
        return Container();
    }
  }
}
