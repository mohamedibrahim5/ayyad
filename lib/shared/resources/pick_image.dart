import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';

import 'colors_manager.dart';

Future<void> _takePhoto(
    ImageSource source,
    void Function(File?) updateImage,
    ) async {
  final pickedImage = await _pickImage(source);

  // final picker = ImagePicker();
  // final pickedImage = await picker.pickImage(source: source,);
  updateImage(pickedImage);

}

Future<File?> _pickImage(ImageSource source) async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: source);
  return pickedImage != null ? File(pickedImage.path) : null;
}





void showImagePicker(BuildContext context,updateImage) {
  showModalBottomSheet(
    context: context,
    backgroundColor: ColorsManager.dropDownColor2,
    builder: (BuildContext context) {
      return SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library,color: ColorsManager.whiteColorText,),
              title:  Text(StringsManager.pickFromGallery.tr(),
              style: Theme.of(context).textTheme.titleMedium,),
              onTap: () {
                _takePhoto(ImageSource.gallery,updateImage);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt,color: ColorsManager.whiteColorText),
              title:  Text(StringsManager.pickFromCamera.tr(),
                style: Theme.of(context).textTheme.titleMedium,),
              onTap: () {
                _takePhoto(ImageSource.camera,updateImage);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}