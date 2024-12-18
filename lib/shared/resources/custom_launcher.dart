import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:ibnelbarh/shared/resources/string_manager.dart';
import 'package:ibnelbarh/shared/resources/utils.dart';


import 'package:url_launcher/url_launcher.dart';

class CustomLauncher {
  Future openFacebookPage(String username) async {
    try {
      await _launchSocialMediaAppIfInstalled(
        url: 'https://www.facebook.com/$username', //FaceBook
      );
    } on Exception {
      Utils.showErrorToast('${StringsManager.couldNotOpen.tr()}${StringsManager.facebook.tr()}');
    }
  }
  Future call(String phoneNumber,String clientName) async {
    try {
      // bool res = await FlutterPhoneDirectCaller.callNumber('01149945599')??false;
      final call = Uri.parse('tel:$phoneNumber');
      if (await canLaunchUrl(call)) {
        launchUrl(call);
      } else {
        throw '${StringsManager.couldNotCall.tr()}$clientName';
      }
    } on Exception {
      Utils.showErrorToast('${StringsManager.couldNotCall.tr()}$clientName');
    }
  }
  Future sendMessage(String phoneNumber,String clientName) async {
    try {
      // bool res = await FlutterPhoneDirectCaller.callNumber('01149945599')??false;
      final message = Uri.parse('sms:$phoneNumber');
      if (await canLaunchUrl(message)) {
        launchUrl(message);
      } else {
        throw '${StringsManager.couldNotCall.tr()}$clientName';
      }
    } on Exception {
      Utils.showErrorToast('${StringsManager.couldNotCall.tr()}$clientName');
    }
  }

  Future openWebsite(String url) async {

    try {
       String  link;
      url.contains('https://')?{
        link=url,
      }:{
        link='https://$url',
      };
      await _launchSocialMediaAppIfInstalled(
        url: link, //Instagram
      );
    } on Exception {
      Utils.showErrorToast('${StringsManager.couldNotOpen.tr()} $url');
    }
  }

  Future openInstagram(String account) async {
    try {
      await _launchSocialMediaAppIfInstalled(
        url: 'https://www.instagram.com/$account', //Instagram
      );
    } on Exception {
      Utils.showErrorToast('${StringsManager.couldNotOpen.tr()} ${StringsManager.instagram.tr()}');
    }
  }

  Future sendEmail(String emailAddress) async {
    try {
      await _launchSocialMediaAppIfInstalled(
        url: 'mailto:$emailAddress', // Linkedin
      );
    } on Exception {
      Utils.showErrorToast('${StringsManager.couldNotOpen.tr()} ${StringsManager.sendEmail.tr()}');
    }
  }

  Future openTwitter(String accountHandle) async {
    try {
      await _launchSocialMediaAppIfInstalled(
        url: 'https://x.com/$accountHandle', // Twitter
      );
    } on Exception {
      Utils.showErrorToast('${StringsManager.couldNotOpen.tr()} ${StringsManager.x.tr()}');
    }
  }

  Future openWhatsApp(String phone) async {
    var androidUrl = "whatsapp://send?phone=$phone";
    var iosUrl = "https://wa.me/$phone";

    try {
      if (Platform.isIOS) {
        await _launchSocialMediaAppIfInstalled(url: iosUrl);
      } else {
        await _launchSocialMediaAppIfInstalled(url: androidUrl);
      }
    } on Exception {
      Utils.showErrorToast('${StringsManager.couldNotOpen.tr()} ${StringsManager.whatsapp.tr()}');
    }
  }

  Future<void> shareWhats({required String invitationCode}) async {
    try {
      String whatsappUrl = "whatsapp://send?text=$invitationCode";

      final Uri uri = Uri.parse(whatsappUrl) ;
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw "Could not launch WhatsApp";
      }
    } on Exception catch (error) {
      debugPrint(
          '--------------------- shareApplication error: $error ------------------------');
    }
  }


  Future openLinkedIn(String account) async => _launchSocialMediaAppIfInstalled(
        url: 'https://www.linkedin.com/company/$account', // Twitter
      );

  Future _launchSocialMediaAppIfInstalled({
    required String url,
  }) async {
    final uri = Uri.parse(url);
    try {
      bool launched = await launchUrl(uri,
          mode: LaunchMode.platformDefault); // Launch the app if installed!

      if (!launched) {
        launchUrl(uri); // Launch web view if app is not installed!
      }
    } catch (e) {
      rethrow; // Launch web view if app is not installed!
    }
  }

  Future<void> launchYoutubeVideo(String youtubeUrl) async {
    try {
      await _launchSocialMediaAppIfInstalled(
        url: 'https://www.youtube.com/$youtubeUrl', //Youtube
      );
    } on Exception {
      Utils.showErrorToast('${StringsManager.couldNotOpen.tr()} ${StringsManager.youtube.tr()}');
    }
  }

  Future openTelegram(String lucnher) async {
    var url = "https://t.me/$lucnher";
    try {
      await _launchSocialMediaAppIfInstalled(url: url);
    } on Exception {
      Utils.showErrorToast('${StringsManager.couldNotOpen.tr()} ${StringsManager.whatsapp.tr()}');
    }
  }


  Future<void> sendMessageTelegram({
    required String phone,
    String? text,
    LaunchMode mode = LaunchMode.externalApplication,
  }) async {
    const String url = 'tg://msg'; //Telegram
    final String? effectiveText = text != null && text.isNotEmpty
        ? '&text=${Uri.encodeFull(text)}'
        : null;

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse('$url?to=+$phone$effectiveText'),
        mode: mode,
      );
    } else {
      Utils.showErrorToast('${StringsManager.couldNotOpen.tr()} ${StringsManager.telegram.tr()}');
    }
  }
}
