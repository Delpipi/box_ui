import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ExampleView extends StatelessWidget {
  const ExampleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        children: [
          BoxText.headingOne('Design System'),
          verticalSpaceSmall,
          const Divider(),
          verticalSpaceSmall,
          ...buttonWidgets,
          ...textWidgets,
          ...inputFields,
          ...drowpdownButtons,
          ...rangeSliders,
        ],
      ),
    );
  }
}

final form = FormGroup({
  'fullName': FormControl<String>(
    value: 'John Doe',
    validators: [Validators.required],
    touched: true,
  ),
  'contact': FormControl<PhoneNumber>(
    value: PhoneNumber(
        countryISOCode: "CI", countryCode: "225", number: "0504888547"),
    validators: [Validators.required],
    touched: true,
  ),
  'price': FormControl<RangeValues>(),
  'payment': FormControl<int>(validators: [Validators.required]),
  'menu':
      FormControl<String>(value: 'Tunisia', validators: [Validators.required]),
  'menuMultiple': FormControl<List<String>>(value: ['Tunisia', 'Brazil']),
  'bottomSheet': FormControl<String>(value: 'Brazil'),
});

List<Widget> get textWidgets => [
      BoxText.headline('Text Styles'),
      verticalSpaceMedium,
      BoxText.headingOne('Heading One'),
      verticalSpaceMedium,
      BoxText.headingTwo('Heading Two'),
      verticalSpaceMedium,
      BoxText.headingThree('Heading Three'),
      verticalSpaceMedium,
      BoxText.headline('Headline'),
      verticalSpaceMedium,
      BoxText.subheading('This will be a sub heading to the headling'),
      verticalSpaceMedium,
      BoxText.body('Body Text that will be used for the general body'),
      verticalSpaceMedium,
      BoxText.caption('This will be the caption usually for smaller details'),
      verticalSpaceMedium,
    ];

List<Widget> get buttonWidgets => [
      BoxText.headline('Buttons'),
      verticalSpaceMedium,
      BoxText.body('Normal'),
      verticalSpaceSmall,
      const BoxButton(
        title: 'SIGN IN',
      ),
      verticalSpaceSmall,
      BoxText.body('Disabled'),
      verticalSpaceSmall,
      const BoxButton(
        title: 'SIGN IN',
        disabled: true,
      ),
      verticalSpaceSmall,
      BoxText.body('Busy'),
      verticalSpaceSmall,
      // BoxButton(
      //   title: 'SIGN IN',
      //   busy: true,
      // ),
      verticalSpaceSmall,
      BoxText.body('Outline'),
      verticalSpaceSmall,
      const BoxButton.outline(
        title: 'Select location',
        leading: Icon(
          Icons.send,
          color: kcPrimaryColor,
        ),
      ),
      verticalSpaceMedium,
    ];

List<Widget> get inputFields => [
      BoxText.headline('Input Field'),
      verticalSpaceSmall,
      ReactiveForm(
        formGroup: form,
        child: ListView(
          shrinkWrap: true,
          children: [
            BoxText.body('Normal'),
            verticalSpaceSmall,
            BoxInputField(
              formControlName: 'fullName',
              placeholder: 'Enter Password',
            ),
            verticalSpaceSmall,
            BoxText.body('Leading Icon'),
            verticalSpaceSmall,
            BoxInputField(
              formControlName: 'fullName',
              leading: const Icon(Icons.reset_tv),
              placeholder: 'Enter TV Code',
            ),
            verticalSpaceSmall,
            BoxText.body('Trailing Icon'),
            verticalSpaceSmall,
            BoxInputField(
              formControlName: 'fullName',
              trailing: const Icon(Icons.clear_outlined),
              placeholder: 'Search for things',
            ),
            verticalSpaceSmall,
            BoxText.body('Contact Field'),
            verticalSpaceSmall,
            BoxInputField.contact(
              formControlName: 'contact',
            ),
          ],
        ),
      )
    ];

List<Widget> get drowpdownButtons => [
      BoxText.headline('DropDown Button'),
      verticalSpaceSmall,
      ReactiveForm(
        formGroup: form,
        child: ListView(
          shrinkWrap: true,
          children: [
            BoxText.body('Normal'),
            verticalSpaceSmall,
            BoxDropdownField<int>(
              formControlName: 'payment',
              placeholder: 'select payment',
              items: const [
                DropdownMenuItem(
                  value: 0,
                  child: Text('Free'),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text('Visa'),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text('Mastercard'),
                ),
                DropdownMenuItem(
                  value: 3,
                  child: Text('PayPal'),
                ),
              ],
            ),
            verticalSpaceSmall,
            BoxText.body('Leading icon'),
            verticalSpaceSmall,
            BoxDropdownField<int>(
              formControlName: 'payment',
              leading: const Icon(Icons.money),
              placeholder: 'select payment',
              items: const [
                DropdownMenuItem(
                  value: 0,
                  child: Text('Free'),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text('Visa'),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text('Mastercard'),
                ),
                DropdownMenuItem(
                  value: 3,
                  child: Text('PayPal'),
                ),
              ],
            ),
            verticalSpaceSmall,
            BoxText.body('Search option'),
            verticalSpaceSmall,
            BoxDropdownField<String>.search(
              formControlName: 'menu',
              searchItems: const [
                "Brazil",
                "Italia (Disabled)",
                "Tunisia",
                'Canada'
              ],
            ),
            verticalSpaceSmall,
            BoxText.body('Multi Search option'),
            verticalSpaceSmall,
            BoxDropdownField<String>.searchMultiSelection(
              formControlName: 'menuMultiple',
              placeholder: "Select a country",
              searchItems: const ["Brazil", "Italia", "Tunisia", 'Canada'],
            ),
          ],
        ),
      )
    ];

List<Widget> get rangeSliders => [
      BoxText.headline('Range Silder'),
      verticalSpaceSmall,
      ReactiveForm(
        formGroup: form,
        child: ListView(
          shrinkWrap: true,
          children: [
            BoxText.body('Normal'),
            verticalSpaceSmall,
            BoxRangeSilder(
              min: 1000000,
              max: 7000000,
              formControlName: 'price',
            ),
          ],
        ),
      )
    ];
