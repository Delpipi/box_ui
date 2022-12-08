// ignore_for_file: must_be_immutable

import 'package:box_ui/src/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class BoxDropdownField<T> extends StatelessWidget {
  final bool search;
  final bool multiSelection;
  final String? formControlName;
  final FormControl<T>? formControl;
  final Map<String, ValidationMessageFunction>? validationMessages;
  List<DropdownMenuItem<T>> items;
  final String? placeholder;
  final Widget? leading;
  BoxDropdownField({
    Key? key,
    this.formControlName,
    this.formControl,
    this.validationMessages,
    required this.items,
    this.leading,
    this.placeholder,
  })  : search = false,
        multiSelection = false,
        super(key: key);
  BoxDropdownField.search({
    Key? key,
    this.formControlName,
    this.formControl,
    this.validationMessages,
    this.leading,
    this.placeholder,
  })  : search = true,
        multiSelection = false,
        items = const [],
        super(key: key);
  BoxDropdownField.searchMultiSelection({
    Key? key,
    this.formControlName,
    this.formControl,
    this.validationMessages,
    this.leading,
    this.placeholder,
  })  : search = true,
        multiSelection = true,
        items = const [],
        super(key: key);

  final circularBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  );

  @override
  Widget build(BuildContext context) {
    return !search
        ? ReactiveDropdownField<T>(
            formControlName: formControlName,
            formControl: formControl,
            validationMessages: validationMessages,
            items: items,
            dropdownColor:
                kcVeryLightGreyColor, // change the color according style color at the end
            decoration: InputDecoration(
              hintText: placeholder,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              filled: true,
              fillColor: kcVeryLightGreyColor,
              prefixIcon: leading,
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
            style: const TextStyle(color: Colors.black), // style color
          )
        : Container();
  }
}
