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
    NetworkImage getImageFile(FileType fileType) {
      switch (fileType) {
        case FileType.image:
          return const NetworkImage(
            'https://img.icons8.com/fluency/512/full-image.png',
          );
        case FileType.audio:
          return const NetworkImage(
            'https://img.icons8.com/external-flat-wichaiwi/512/external-audio-non-fungible-token-flat-wichaiwi.png',
          );
        case FileType.video:
          return const NetworkImage(
            'https://img.icons8.com/fluency/512/video.png',
          );
        default:
          return const NetworkImage(
            'https://img.icons8.com/avantgarde/512/file.png',
          );
      }
    }

    return Container(
      constraints: const BoxConstraints(minHeight: 0, maxHeight: 200),
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
                .map((key, value) => MapEntry(
                    key,
                    ListTile(
                      onTap: () => applaunchUrl(Uri.parse(value)),
                      leading: GFAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: getImageFile(type),
                        shape: GFAvatarShape.circle,
                      ),
                      title: BoxText.caption(
                          value.split(Platform.pathSeparator).last),
                      trailing: InkWell(
                        onTap: () => onChange(files.copyWith(
                            files: List<String>.from(files.files)
                              ..removeAt(key))),
                        child: const Icon(
                          Icons.close,
                          color: kcMediumGreyColor,
                        ),
                      ),
                    )))
                .values,
            ...files.platformFiles
                .asMap()
                .map((key, value) => MapEntry(
                      key,
                      ListTile(
                        onTap: () =>
                            applaunchUrl(Uri.parse("file:${value.path}")),
                        leading: GFAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: getImageFile(type),
                          shape: GFAvatarShape.circle,
                        ),
                        title: BoxText.caption(
                          value.path!.split(Platform.pathSeparator).last,
                        ),
                        trailing: InkWell(
                          onTap: () => onChange(files.copyWith(
                              platformFiles:
                                  List<PlatformFile>.from(files.platformFiles)
                                    ..removeAt(key))),
                          child: const Icon(
                            Icons.close,
                            color: kcMediumGreyColor,
                          ),
                        ),
                      ),
                    ))
                .values,
          ];

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (_, i) {
                    return items[i];
                  },
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

Future<void> applaunchUrl(Uri? uri) async {
  if (uri != null) {
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch ${uri.path}');
    }
  }
}
