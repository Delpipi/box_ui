import 'package:box_ui/src/shared/app_colors.dart';
import 'package:box_ui/src/shared/ui_helpers.dart';
import 'package:box_ui/src/widgets/box_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_range_slider/reactive_range_slider.dart';
import 'box_range_slider_controller.dart';

class BoxRangeSilder extends StatelessWidget {
  final formatter = NumberFormat('#,###');
  final double min;
  final double max;
  final int? divisions;
  final String? formControlName;
  final FormControl<RangeValues>? formControl;
  final Map<String, ValidationMessageFunction>? validationMessages;
  final String? placeholder;

  BoxRangeSilder({
    Key? key,
    required this.min,
    required this.max,
    this.divisions = 6,
    this.formControlName,
    this.formControl,
    this.validationMessages,
    this.placeholder,
  }) : super(key: key);

  BoxRangeSliderController controller =
      Get.put<BoxRangeSliderController>(BoxRangeSliderController());

  @override
  Widget build(BuildContext context) {
    controller.initialise(min, max);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Obx(
          () => SizedBox(
            width: 70.0,
            child: BoxText.caption(
              formatter
                  .format(controller.min.value.round())
                  .replaceAll(',', ' '),
            ),
          ),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackShape: const RoundedRectSliderTrackShape(),
              activeTrackColor: kcMediumGreyColor, // slider line
              inactiveTrackColor: kcLightGreyColor, // slider line
              thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: 14.0,
                pressedElevation: 8.0,
              ),
              thumbColor: kcMediumGreyColor, // slider selection circle
              overlayColor: Colors.transparent,
              tickMarkShape: const RoundSliderTickMarkShape(),
              activeTickMarkColor: kcLightGreyColor, // slider divisions
              inactiveTickMarkColor: kcVeryLightGreyColor,
            ),
            child: ReactiveRangeSlider<RangeValues>(
              formControlName: formControlName,
              formControl: formControl,
              validationMessages: validationMessages,
              min: min,
              max: max,
              divisions: divisions,
              onChangeEnd: (values) {
                controller.max.value = values.end;
              },
              onChangeStart: (values) {
                controller.min.value = values.start;
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: placeholder,
                helperText: placeholder,
              ),
            ),
          ),
        ),
        Obx(
          () => SizedBox(
            width: 70.0,
            child: BoxText.caption(
              formatter
                  .format(controller.max.value.round())
                  .replaceAll(',', ' '),
            ),
          ),
        ),
      ],
    );
  }
}
