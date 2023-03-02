import 'dart:io';
import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:url_launcher/url_launcher.dart';

class BoxFilePicker extends StatelessWidget {
  final String? formControlName;
  final FormControl<MultiFile<String>>? formControl;
  final Map<String, ValidationMessageFunction>? validationMessages;
  final ShowErrorsFunction? showErrors;
  final String placeholder;
  final String? dialogTitle;
  final FileType type;
  final bool allowMultiple;
  final List<String>? allowedExtensions;
  final String? pickerButtonTitle;

  final circularBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  );

  BoxFilePicker({
    Key? key,
    this.formControlName,
    this.formControl,
    this.validationMessages,
    this.placeholder = '',
    this.allowedExtensions,
    this.dialogTitle,
    this.type = FileType.any,
    this.allowMultiple = false,
    this.showErrors,
    this.pickerButtonTitle,
  }) : super(key: key);

  BoxFilePicker.audio({
    Key? key,
    this.formControlName,
    this.formControl,
    this.validationMessages,
    this.placeholder = '',
    this.allowedExtensions,
    this.dialogTitle,
    this.type = FileType.audio,
    this.showErrors,
    this.pickerButtonTitle,
  })  : allowMultiple = false,
        super(key: key);

  BoxFilePicker.image({
    Key? key,
    this.formControlName,
    this.formControl,
    this.validationMessages,
    this.placeholder = '',
    this.allowedExtensions,
    this.dialogTitle,
    this.type = FileType.image,
    this.showErrors,
    this.pickerButtonTitle,
  })  : allowMultiple = false,
        super(key: key);

  BoxFilePicker.video({
    Key? key,
    this.formControlName,
    this.formControl,
    this.validationMessages,
    this.placeholder = '',
    this.allowedExtensions,
    this.dialogTitle,
    this.type = FileType.video,
    this.showErrors,
    this.pickerButtonTitle,
  })  : allowMultiple = false,
        super(key: key);

  BoxFilePicker.multipleAudio({
    Key? key,
    this.formControlName,
    this.formControl,
    this.validationMessages,
    this.placeholder = '',
    this.allowedExtensions,
    this.dialogTitle,
    this.type = FileType.audio,
    this.showErrors,
    this.pickerButtonTitle,
  })  : allowMultiple = true,
        super(key: key);

  BoxFilePicker.multipleImage({
    Key? key,
    this.formControlName,
    this.formControl,
    this.validationMessages,
    this.placeholder = '',
    this.allowedExtensions,
    this.dialogTitle,
    this.type = FileType.image,
    this.showErrors,
    this.pickerButtonTitle,
  })  : allowMultiple = true,
        super(key: key);

  BoxFilePicker.multipleVideo({
    Key? key,
    this.formControlName,
    this.formControl,
    this.validationMessages,
    this.placeholder = '',
    this.allowedExtensions,
    this.dialogTitle,
    this.type = FileType.video,
    this.showErrors,
    this.pickerButtonTitle,
  })  : allowMultiple = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Image getImageFile(FileType fileType) {
      switch (fileType) {
        case FileType.image:
          return Image.network(
            'https://img.icons8.com/fluency/512/full-image.png',
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          );
        case FileType.audio:
          return Image.network(
            'https://img.icons8.com/external-flat-wichaiwi/512/external-audio-non-fungible-token-flat-wichaiwi.png',
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          );
        case FileType.video:
          return Image.network(
            'https://img.icons8.com/fluency/512/video.png',
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          );
        default:
          return Image.network(
            'https://img.icons8.com/avantgarde/512/file.png',
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          );
      }
    }

    return Container(
      constraints: const BoxConstraints(minHeight: 0, maxHeight: 150),
      child: ReactiveFilePicker<String>(
        formControlName: formControlName,
        formControl: formControl,
        allowMultiple: allowMultiple,
        validationMessages: validationMessages,
        showErrors: showErrors,
        filePickerBuilder: (pickImage, files, onChange) {
          if (!allowMultiple && files.files.length >= 2) {
            onChange(files.copyWith(
                files: List<String>.from(files.files)..removeAt(0)));
          } else if (!allowMultiple && files.platformFiles.isNotEmpty) {
            if (files.files.isNotEmpty) {
              onChange(files.copyWith(
                  files: List<String>.from(files.files)..removeAt(0)));
            }
            if (!allowMultiple && files.platformFiles.length >= 2) {
              onChange(files.copyWith(
                  platformFiles: List<PlatformFile>.from(files.platformFiles)
                    ..removeAt(0)));
            }
          }
          final items = [
            ...files.files
                .asMap()
                .map(
                  (key, value) => MapEntry(
                    key,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BoxText.caption(
                          value.split(Platform.pathSeparator).last,
                          align: TextAlign.center,
                        ),
                        verticalSpaceTiny,
                        Flexible(child: getImageFile(type)),
                        verticalSpaceTiny,
                        Flexible(
                          child: GFButtonBar(
                            children: <Widget>[
                              InkWell(
                                child: const GFAvatar(
                                  backgroundColor: GFColors.SUCCESS,
                                  size: sizeMedium,
                                  child: Icon(
                                    Icons.visibility,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () async {
                                  if (!await launchUrl(Uri.parse(value))) {
                                    throw Exception('Could not launch $value');
                                  }
                                },
                              ),
                              InkWell(
                                child: const GFAvatar(
                                  backgroundColor: GFColors.DANGER,
                                  size: sizeMedium,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  onChange(files.copyWith(
                                      files: List<String>.from(files.files)
                                        ..removeAt(key)));
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .values
                .toList(),
            ...files.platformFiles
                .asMap()
                .map(
                  (key, value) => MapEntry(
                    key,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BoxText.caption(
                          value.path!.split(Platform.pathSeparator).last,
                          align: TextAlign.center,
                        ),
                        verticalSpaceTiny,
                        Flexible(child: getImageFile(type)),
                        verticalSpaceTiny,
                        Flexible(
                          child: GFButtonBar(
                            children: <Widget>[
                              InkWell(
                                child: const GFAvatar(
                                  backgroundColor: GFColors.SUCCESS,
                                  size: sizeMedium,
                                  child: Icon(
                                    Icons.visibility,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () async {
                                  if (value.path != null) {
                                    if (!await launchUrl(
                                        Uri.file(value.path!))) {
                                      throw Exception(
                                          'Could not launch $value');
                                    }
                                  }
                                },
                              ),
                              InkWell(
                                child: const GFAvatar(
                                  backgroundColor: GFColors.DANGER,
                                  size: sizeMedium,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  onChange(files.copyWith(
                                      files: List<String>.from(files.files)
                                        ..removeAt(key)));
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .values
                .toList(),
          ];

          return Column(
            children: [
              Expanded(
                child: GridView.count(
                  crossAxisCount: 3,
                  children: List.generate(items.length, (index) {
                    return items[index];
                  }),
                ),
              ),
              verticalSpaceSmall,
              BoxButton(
                title: pickerButtonTitle ?? "",
                leading: const Icon(
                  Icons.file_open,
                  color: Colors.white,
                ),
                onTap: pickImage,
              )
            ],
          );
        },
      ),
    );
  }
}
