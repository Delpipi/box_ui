import 'package:box_ui/src/shared/ui_helpers.dart';
import 'package:box_ui/src/widgets/box_input_field/contact_controller.dart';
import 'package:box_ui/src/widgets/box_input_field/countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'phone_number.dart';

class ContactPage extends ReactiveFormField<PhoneNumber, String> {
  final TextEditingController? _textController;
  final ContactController controller = Get.put(ContactController());
  ContactPage({
    Key? key,
    required BuildContext context,
    String? formControlName,
    FormControl<PhoneNumber>? formControl,
    Map<String, ValidationMessageFunction>? validationMessages,
    ControlValueAccessor<PhoneNumber, String>? valueAccessor,
    ShowErrorsFunction<PhoneNumber>? showErrors,
    FocusNode? focusNode,
    TextEditingController? controller,
    InputDecoration? decoration = const InputDecoration(),
  })  : _textController = controller,
        super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          focusNode: focusNode,
          builder: (ReactiveFormFieldState<PhoneNumber, String> field) {
            final state = field as _ContactPageState;
            return Obx(
              () => TextField(
                controller: state._textController,
                focusNode: state.focusNode,
                keyboardType: TextInputType.number,
                decoration: decoration?.copyWith(
                  errorText: state._controller.errorMessage.value,
                  prefixIcon: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(sizeSmall),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/flags/${state._controller.selectedCountry.value.code.toLowerCase()}.png',
                            package: "box_ui",
                            width: 32,
                          ),
                          horizontalSpaceTiny,
                          FittedBox(
                            child: Text(
                              '+${state._controller.selectedCountry.value.dialCode}',
                            ),
                          ),
                          horizontalSpaceSmall,
                        ],
                      ),
                    ),
                    onTap: () async {
                      await showDialog(
                        context: context,
                        useRootNavigator: false,
                        builder: (context) => StatefulBuilder(
                          builder: (ctx, setState) => Dialog(
                            insetPadding: const EdgeInsets.symmetric(
                                vertical: sizeSmall, horizontal: sizeLarge),
                            child: Container(
                              padding: const EdgeInsets.all(sizeSmall),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: TextField(
                                      decoration: const InputDecoration(
                                        suffixIcon: Icon(Icons.search),
                                        labelText: "",
                                      ),
                                      onChanged: (value) {},
                                    ),
                                  ),
                                  verticalSpaceMedium,
                                  Expanded(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          state._controller.countryList.length,
                                      itemBuilder: (ctx, index) => Column(
                                        children: [
                                          ListTile(
                                            leading: Image.asset(
                                              'assets/flags/${state._controller.countryList[index].code.toLowerCase()}.png',
                                              package: "box_ui",
                                              width: 32,
                                            ),
                                            title: Text(
                                              state._controller
                                                  .countryList[index].name,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            trailing: Text(
                                              '+${state._controller.countryList[index].dialCode}',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            onTap: () {
                                              state._controller.selectedCountry
                                                      .value =
                                                  state._controller
                                                      .countryList[index];

                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          const Divider(thickness: 1),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                onChanged: (value) {
                  field.didChange(value);
                },
                maxLength: state._controller.selectedCountry.value.maxLength,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ], // Only numbers can be entered
              ),
            );
          },
        );

  @override
  ReactiveFormFieldState<PhoneNumber, String> createState() =>
      _ContactPageState();
}

class _ContactPageState
    extends ReactiveFocusableFormFieldState<PhoneNumber, String> {
  late TextEditingController _textController;
  late ContactController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(ContactController());
    _initializeTextController();
  }

  @override
  void onControlValueChanged(dynamic value) {
    final effectiveValue = (value == null) ? '' : value.toString();
    _textController.value = _textController.value.copyWith(
      text: effectiveValue,
      selection: TextSelection.collapsed(offset: effectiveValue.length),
      composing: TextRange.empty,
    );
    _controller.onValueChange(_textController.value.text);
    super.onControlValueChanged(value);
  }

  @override
  ControlValueAccessor<PhoneNumber, String> selectValueAccessor() {
    return PhoneNumber();
  }

  void _initializeTextController() {
    final initialValue = value;
    final currentWidget = widget as ContactPage;
    _textController = (currentWidget._textController != null)
        ? currentWidget._textController!
        : TextEditingController();
    _textController.text = initialValue == null ? '' : initialValue.toString();
  }
}
