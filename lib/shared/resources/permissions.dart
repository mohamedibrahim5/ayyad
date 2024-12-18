import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandling{
  static Future<bool> requestPhotosPermission() async {
    PermissionStatus status = await Permission.photos.status;

    if (status != PermissionStatus.granted) {
      status = await Permission.photos.request();
    }else if(status == PermissionStatus.permanentlyDenied){
      await openAppSettings();
    }
    return status == PermissionStatus.granted;
  }
  static Future<bool> requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      status = await Permission.storage.request();
    }else if(status == PermissionStatus.permanentlyDenied){
      await openAppSettings();
    }
    return status == PermissionStatus.granted;
  }
  static Future<bool> requestGalleryPermission()async{
    if(Platform.isIOS){
      return await requestPhotosPermission();
    }else{
      DeviceInfoPlugin plugin = DeviceInfoPlugin();
      AndroidDeviceInfo android = await plugin.androidInfo;
      if(android.version.sdkInt<33){
        return await requestStoragePermission();
      }else{
        return await requestPhotosPermission();
      }
    }
  }
  /*static Future<bool> requestContactsPermission()async{
    PermissionStatus status = await Permission.contacts.request();
    if(status != PermissionStatus.granted){
      status = await Permission.contacts.request();
    }else if(status == PermissionStatus.permanentlyDenied){
      await openAppSettings();
    }
    return status == PermissionStatus.granted;
  }
  static Future<bool> requestMicPermission()async{
    PermissionStatus status = await Permission.microphone.request();
    if(status == PermissionStatus.permanentlyDenied){
      await openAppSettings();
    }else if(status != PermissionStatus.granted){
      status = await Permission.microphone.request();
    }
    return status == PermissionStatus.granted;
  }*/
  static Future<bool> requestCameraPermission()async{
    PermissionStatus status = await Permission.camera.request();
    if(status != PermissionStatus.granted){
      status = await Permission.camera.request();
    }else if(status == PermissionStatus.permanentlyDenied){
      await openAppSettings();
    }
    return status == PermissionStatus.granted;
  }

  static Future<bool> requestLocationPermission()async{
    PermissionStatus status = await Permission.location.request();
    if(status != PermissionStatus.granted){
      status = await Permission.camera.request();
    }else if(status == PermissionStatus.permanentlyDenied){
      await openAppSettings();
    }
    return status == PermissionStatus.granted;
  }
}