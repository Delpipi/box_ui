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
          ...filePickerButtons,
          ...drowpdownButtons,
          ...rangeSliders,
          ...dateTimeFields,
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
    value: const PhoneNumber(isoCode: IsoCode.CI, nsn: "0504888547"),
    validators: [_requiredTrue, _invalidPhoneLength],
    touched: true,
  ),
  'image': FormControl<ImageFile>(),
  'price': FormControl<RangeValues>(),
  'payment': FormControl<int>(validators: [Validators.required]),
  'menu':
      FormControl<String>(value: 'Tunisia', validators: [Validators.required]),
  'menuMultiple': FormControl<List<String>>(value: ['Tunisia', 'Brazil']),
  'bottomSheet': FormControl<String>(value: 'Brazil'),
  'date': FormControl<DateTime>(value: DateTime.now()),
  'time': FormControl<DateTime>(value: DateTime.now()),
  'dateTime': FormControl<DateTime>(),
  'dateTimeNullable': FormControl<DateTime>(value: null),
});

final filePickerForm = fb.group({
  'multiImage': FormControl<MultiFile<String>>(
    value: const MultiFile<String>(
      files: [
        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg'
      ],
      platformFiles: [],
    ),
  ),
});

Map<String, dynamic>? _requiredTrue(AbstractControl<dynamic> control) {
  return control.isNotNull &&
          control.value is PhoneNumber &&
          control.value!.nsn.trim().isNotEmpty
      ? null
      : {'requiredTrue': true};
}

Map<String, dynamic>? _invalidPhoneLength(AbstractControl<dynamic> control) {
  return control.isNotNull &&
          control.value is PhoneNumber &&
          control.value.isValid(type: PhoneNumberType.mobile)
      ? null
      : {'invalidPhoneLength': true};
}

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
              leading: const Icon(Icons.phone),
              validationMessages: {
                'requiredTrue': (error) => "Merci de saisir votre contact",
                'invalidPhoneLength': (error) => "Votre numéro n'est pas valide"
              },
            ),
            verticalSpaceSmall,
            BoxText.body("TextArea"),
            verticalSpaceSmall,
            BoxInputField.textArea(
              formControlName: 'fullName',
              placeholder: 'Enter Password',
            ),
            verticalSpaceSmall,
            BoxText.body("Image Picker"),
            verticalSpaceSmall,
            BoxInputField.imagePicker(
              formControlName: 'image',
              placeholder: 'Prendre une image',
            ),
            verticalSpaceMedium,
          ],
        ),
      )
    ];

List<Widget> get filePickerButtons => [
      BoxText.headline('File picker'),
      verticalSpaceSmall,
      ReactiveForm(
        formGroup: filePickerForm,
        child: ListView(
          shrinkWrap: true,
          children: [
            BoxText.body('picker image'),
            verticalSpaceSmall,
            BoxFilePicker.image(
              formControlName: 'multiImage',
              placeholder: 'Select',
            ),
            verticalSpaceSmall,
            BoxText.body('picker video Leading Icon'),
            verticalSpaceSmall,
            BoxFilePicker.video(
              formControlName: 'multiImage',
              placeholder: 'Select',
            ),
            verticalSpaceSmall,
            BoxText.body('Picker audio'),
            verticalSpaceSmall,
            BoxFilePicker.audio(
              formControlName: 'multiImage',
              placeholder: 'Select',
            ),
            verticalSpaceMedium,
            BoxText.body('Mutiple selection'),
            verticalSpaceSmall,
            BoxText.body('Mutiple Image'),
            BoxFilePicker.multipleImage(
              formControlName: 'multiImage',
              placeholder: 'Select',
            ),
            verticalSpaceSmall,
            BoxText.body("Multiple video"),
            verticalSpaceSmall,
            BoxFilePicker.multipleVideo(
              formControlName: 'multiImage',
              placeholder: 'Select',
            ),
            verticalSpaceMedium,
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

List<Widget> get dateTimeFields => [
      BoxText.headline('Date Time Field'),
      verticalSpaceSmall,
      ReactiveForm(
        formGroup: form,
        child: ListView(
          shrinkWrap: true,
          children: [
            BoxText.body('Date Field'),
            verticalSpaceSmall,
            BoxDateTimeField.date(
              formControlName: 'date',
              leading: Icon(Icons.calendar_today),
            ),
            verticalSpaceSmall,
            BoxText.body('Time Field'),
            verticalSpaceSmall,
            BoxDateTimeField.time(
              formControlName: 'time',
              leading: Icon(Icons.calendar_today),
            ),
            verticalSpaceSmall,
            BoxText.body('DateTime Field'),
            verticalSpaceSmall,
            BoxDateTimeField.dateTime(
              formControlName: 'dateTime',
              placeholder: 'Datetime',
              leading: Icon(Icons.calendar_today),
            ),
            verticalSpaceMedium,
          ],
        ),
      )
    ];
