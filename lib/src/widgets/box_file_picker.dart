import 'dart:io';

import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:better_player/better_player.dart';

class BoxFilePicker extends StatelessWidget {
  final String? formControlName;
  final FormControl<MultiFile<String>>? formControl;
  final Map<String, ValidationMessageFunction>? validationMessages;
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
  })  : allowMultiple = true,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 0, maxHeight: 300),
      child: ReactiveFilePicker<String>(
        formControlName: formControlName,
        formControl: formControl,
        allowMultiple: allowMultiple,
        filePickerBuilder: (pickImage, files, onChange) {
          final items = [
            ...files.files
                .asMap()
                .map(
                  (key, value) => MapEntry(
                    key,
                    ListTile(
                      minLeadingWidth: sizeTiny,
                      horizontalTitleGap: sizeTiny,
                      onTap: () {
                        onChange(files.copyWith(
                            files: List<String>.from(files.files)
                              ..removeAt(key)));
                      },
                      leading: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      title: FileListItem(value, type).build(context),
                    ),
                  ),
                )
                .values,
            ...files.platformFiles
                .asMap()
                .map(
                  (key, value) => MapEntry(
                    key,
                    ListTile(
                      minLeadingWidth: sizeTiny,
                      onTap: () {
                        onChange(files.copyWith(
                            platformFiles:
                                List<PlatformFile>.from(files.platformFiles)
                                  ..removeAt(key)));
                      },
                      leading: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      title: PlatformFileListItem(value, type).build(context),
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
              ElevatedButton(
                onPressed: pickImage,
                child: const Text("selectionné"),
              ),
            ],
          );
        },
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          labelText: placeholder,
          filled: true,
          fillColor: kcVeryLightGreyColor,
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
      ),
    );
  }
}

abstract class ListItem {
  Widget build(BuildContext context);
}

class FileListItem extends ListItem {
  final String url;
  final FileType fileType;

  FileListItem(this.url, this.fileType);

  @override
  Widget build(context) {
    switch (fileType) {
      case FileType.image:
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 96.0,
              height: 96.0,
              child: Image.network(
                'https://img.icons8.com/fluency/512/full-image.png',
              ),
            ),
            verticalSpaceTiny,
            BoxText.caption(
              url.split(Platform.pathSeparator).last,
              align: TextAlign.center,
            ),
          ],
        );
      case FileType.audio:
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 96.0,
              height: 96.0,
              child: Image.network(
                'https://img.icons8.com/external-flat-wichaiwi/512/external-audio-non-fungible-token-flat-wichaiwi.png',
              ),
            ),
            verticalSpaceTiny,
            BoxText.caption(
              url.split(Platform.pathSeparator).last,
              align: TextAlign.center,
            ),
          ],
        );
      case FileType.video:
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 96.0,
              height: 96.0,
              child: Image.network(
                'https://img.icons8.com/fluency/512/video.png',
              ),
            ),
            verticalSpaceTiny,
            BoxText.caption(
              url.split(Platform.pathSeparator).last,
              align: TextAlign.center,
            ),
          ],
        );
      default:
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 96.0,
              height: 96.0,
              child: Image.network(
                'https://img.icons8.com/avantgarde/512/file.png',
              ),
            ),
            verticalSpaceTiny,
            BoxText.caption(
              url.split(Platform.pathSeparator).last,
              align: TextAlign.center,
            ),
          ],
        );
    }
  }
}

class PlatformFileListItem extends ListItem {
  final PlatformFile platformFile;
  final FileType fileType;

  PlatformFileListItem(this.platformFile, this.fileType);

  @override
  Widget build(context) {
    switch (fileType) {
      case FileType.image:
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 96.0,
              height: 96.0,
              child: Image.network(
                'https://img.icons8.com/fluency/512/full-image.png',
              ),
            ),
            verticalSpaceTiny,
            BoxText.caption(
              platformFile.path?.split(Platform.pathSeparator).last ?? '',
              align: TextAlign.center,
            ),
          ],
        );
      case FileType.audio:
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 96.0,
              height: 96.0,
              child: Image.network(
                'https://img.icons8.com/external-flat-wichaiwi/512/external-audio-non-fungible-token-flat-wichaiwi.png',
              ),
            ),
            verticalSpaceTiny,
            BoxText.caption(
              platformFile.path?.split(Platform.pathSeparator).last ?? '',
              align: TextAlign.center,
            ),
          ],
        );
      case FileType.video:
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 96.0,
              height: 96.0,
              child: Image.network(
                'https://img.icons8.com/fluency/512/video.png',
              ),
            ),
            verticalSpaceTiny,
            BoxText.caption(
              platformFile.path?.split(Platform.pathSeparator).last ?? '',
              align: TextAlign.center,
            ),
          ],
        );
      default:
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 96.0,
              height: 96.0,
              child: Image.network(
                'https://img.icons8.com/avantgarde/512/file.png',
              ),
            ),
            verticalSpaceTiny,
            BoxText.caption(
              platformFile.path?.split(Platform.pathSeparator).last ?? '',
              align: TextAlign.center,
            ),
          ],
        );
    }
  }
}
