import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ibnelbarh/shared/resources/permissions.dart';

import 'colors_manager.dart';


class ImageField extends StatelessWidget {
  final void Function(XFile? image) chooseImageCallBack;
  final XFile? image;
  const ImageField({super.key, required this.chooseImageCallBack,required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final image = await chooseImageFromGallery();
        chooseImageCallBack(image);
      },
      child: Container(
        height: 55.h,
        decoration: BoxDecoration(
          color: ColorsManager.whiteColor,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child:  Padding(padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            image!=null && image!.path.isNotEmpty?  Image.file(File(image!.path)):const SizedBox(),
              const Icon(Icons.camera_alt, color: Color(0xff878686)),

            ],
          ),
        ),
      ),
    );
  }
}

Future<File?> chooseImageFromCamera() async {
  bool permissionStorageGranted =
      await PermissionHandling.requestCameraPermission();
  if (permissionStorageGranted) {
    ImagePicker imagePicker = ImagePicker();
    XFile? result = await imagePicker.pickImage(source: ImageSource.camera);
    if (result != null) {
      return File(result.path);
    }
  }
  return null;
}

Future<XFile?> chooseImageFromGallery() async {
  bool permissionStorageGranted =
      await PermissionHandling.requestGalleryPermission();
  if (permissionStorageGranted) {
    ImagePicker imagePicker = ImagePicker();
    XFile? result = await imagePicker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      return result;
    }
  }
  return null;
}
