import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ExampleView extends StatelessWidget {
  ExampleView({super.key});

  
  final form = FormGroup({
    'fullName': FormControl<String>(
      value: 'John Doe',
      validators: [Validators.required],
      touched: true,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        children:   [
          BoxText.headingOne('Design System'),
          BoxButton(title: 'SIGN IN'),
          ReactiveForm(
            formGroup: form,
            child: BoxInputField(formControlName: 'fullName',placeholder: 'Nom et Prénom',),
          )
        ],
      ),
    );
  }
}

