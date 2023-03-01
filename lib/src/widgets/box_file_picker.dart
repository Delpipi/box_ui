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
  })  : allowMultiple = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Image getImageFile(FileType fileType) {
      switch (fileType) {
        case FileType.image:
          return Image.network(
            'https://img.icons8.com/fluency/512/full-image.png',
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          );
        case FileType.audio:
          return Image.network(
            'https://img.icons8.com/external-flat-wichaiwi/512/external-audio-non-fungible-token-flat-wichaiwi.png',
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          );
        case FileType.video:
          return Image.network(
            'https://img.icons8.com/fluency/512/video.png',
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          );
        default:
          return Image.network(
            'https://img.icons8.com/avantgarde/512/file.png',
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          );
      }
    }

    return Container(
      constraints: const BoxConstraints(minHeight: 0, maxHeight: 300),
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
                    GFCard(
                      boxFit: BoxFit.cover,
                      titlePosition: GFPosition.start,
                      image: getImageFile(type),
                      showImage: true,
                      title: GFListTile(
                        title: BoxText.caption(
                          value.split(Platform.pathSeparator).last,
                          align: TextAlign.center,
                        ),
                      ),
                      buttonBar: GFButtonBar(
                        children: <Widget>[
                          InkWell(
                            child: const GFAvatar(
                              backgroundColor: GFColors.SUCCESS,
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
                  ),
                )
                .values,
            ...files.platformFiles
                .asMap()
                .map(
                  (key, value) => MapEntry(
                    key,
                    GFCard(
                      boxFit: BoxFit.cover,
                      titlePosition: GFPosition.start,
                      image: getImageFile(type),
                      showImage: true,
                      title: GFListTile(
                        title: BoxText.caption(
                          value.path!.split(Platform.pathSeparator).last,
                          align: TextAlign.center,
                        ),
                      ),
                      buttonBar: GFButtonBar(
                        children: <Widget>[
                          InkWell(
                            child: const GFAvatar(
                              backgroundColor: GFColors.SUCCESS,
                              child: Icon(
                                Icons.visibility,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () async {
                              if (value.path != null) {
                                if (!await launchUrl(
                                    Uri.parse('file://${value.path}'))) {
                                  throw Exception('Could not launch $value');
                                }
                              }
                            },
                          ),
                          InkWell(
                            child: const GFAvatar(
                              backgroundColor: GFColors.DANGER,
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            onTap: () {
                              onChange(files.copyWith(
                                  platformFiles: List<PlatformFile>.from(
                                      files.platformFiles)
                                    ..removeAt(key)));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .values,
          ];

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (_, i) {
                    return items[i];
                  },
                ),
              ),
              verticalSpaceSmall,
              FloatingActionButton.small(
                elevation: 0.0,
                backgroundColor: kcPrimaryColor,
                onPressed: pickImage,
                child: const Icon(Icons.add),
              ),
            ],
          );
        },
      ),
    );
  }
}
