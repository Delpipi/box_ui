// ignore_for_file: must_be_immutable

import 'package:box_ui/src/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:reactive_dropdown_search/reactive_dropdown_search.dart';
import 'package:reactive_forms/reactive_forms.dart';

class BoxDropdownField<T> extends StatelessWidget {
  final bool search;
  final bool multiSelection;
  final String? formControlName;
  FormControl<T>? formControl;
  FormControl<List<T>>? searchFormControl;
  final Map<String, ValidationMessageFunction>? validationMessages;
  List<DropdownMenuItem<T>> items;
  List<T> searchItems;
  PopupPropsMultiSelection<T>? popupProps;
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
        searchItems = [],
        super(key: key);

  BoxDropdownField.search({
    Key? key,
    this.formControlName,
    this.formControl,
    this.validationMessages,
    this.leading,
    this.placeholder,
    required this.searchItems,
    this.popupProps,
  })  : search = true,
        multiSelection = false,
        items = const [],
        super(key: key);

  BoxDropdownField.searchMultiSelection({
    Key? key,
    this.formControlName,
    this.searchFormControl,
    this.validationMessages,
    this.leading,
    this.placeholder,
    required this.searchItems,
    this.popupProps,
  })  : search = true,
        multiSelection = true,
        items = const [],
        super(key: key);

  final circularBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  );

  @override
  Widget build(BuildContext context) {
    final boxDecoration = InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      hintText: placeholder,
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
    );
    return !search
        ? ReactiveDropdownField<T>(
            formControlName: formControlName,
            formControl: formControl,
            validationMessages: validationMessages,
            items: items,
            dropdownColor:
                kcVeryLightGreyColor, // change the color according style color at the end
            decoration: boxDecoration,
            style: const TextStyle(color: Colors.black), // style color
          )
        : multiSelection
            ? ReactiveDropdownSearchMultiSelection<T, T>(
                formControlName: formControlName,
                formControl: searchFormControl,
                validationMessages: validationMessages,
                dropdownDecoratorProps: DropDownDecoratorProps(
                  baseStyle: const TextStyle(color: Colors.black),
                  dropdownSearchDecoration: boxDecoration,
                ),
                popupProps: popupProps ??
                    const PopupPropsMultiSelection.menu(showSearchBox: true),
                items: searchItems,
                showClearButton: true,
              )
            : ReactiveDropdownSearch<T, T>(
                formControlName: formControlName,
                formControl: formControl,
                validationMessages: validationMessages,
                dropdownDecoratorProps: DropDownDecoratorProps(
                  baseStyle: const TextStyle(color: Colors.black),
                  dropdownSearchDecoration: boxDecoration,
                ),
                popupProps: popupProps ??
                    const PopupPropsMultiSelection.menu(showSearchBox: true),
                items: searchItems,
                showClearButton: true,
              );
  }
}
