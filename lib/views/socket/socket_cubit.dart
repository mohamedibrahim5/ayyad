import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


import '../../shared/resources/constant.dart';
import '../../shared/resources/prefs_helper.dart';
import '../../shared/resources/service_locator.dart';



part 'socket_state.dart';

class SocketCubit extends Cubit<SocketState> {
  SocketCubit() : super(SocketInitial());

  static SocketCubit get(context) => BlocProvider.of(context);
  Stream? appStreamChannel;
  late StreamController internalController;
  Stream<dynamic>? internalStream;
  WebSocketChannel? channelController;

  void openChannel() {
    debugPrint('error is ali');
    runZonedGuarded(() async{
      final token = sl<PrefsHelper>().getToken2().isEmpty ? sl<PrefsHelper>().getSession2() : sl<PrefsHelper>().getToken2();
      debugPrint('from socket cubit $token');
      channelController = WebSocketChannel.connect(
          Uri.parse("${Constants.baseSocketUrl}token=$token"));
      debugPrint('from socket cubit ${channelController.toString()}');
      appStreamChannel =
          channelController!.stream.asBroadcastStream(onCancel: (sub) async {
        if (kDebugMode) {
           debugPrint('error is5 21212 a7a 5555555555555555');
        }
        if (internalStream != null) {
          debugPrint('error is5sssaaa');
          Future.delayed(const Duration(seconds: 5), () {
            channelController!.sink.close();
            openChannel();
          });
        } else {
          debugPrint('error is5sssaaasssssssssssssssssssssssssssss');
        }
      });
      try {
        appStreamChannel?.listen((data) async {
          debugPrint("Socket Socket $data");
          internalController.sink.add(data);
          debugPrint('error is5sss');
        }, onError: (error) {
          if (appStreamChannel == null) {
            if (kDebugMode) {
              debugPrint("error is Socket $error");
            }
            Future.delayed(const Duration(seconds: 5), () {
              channelController?.sink.close();
              runZonedGuarded(
                () {
                  debugPrint('error is5 ff');
                  openChannel();
                },
                (error, stack) {
                  if (kDebugMode) {
                    // debugPrint("error is5 Catch Error A7a  $error");
                  }
                },
              );
            });
          }
        }, onDone: () {
          if (kDebugMode) {
            debugPrint('error is5 14 ');
          }
        });
      } catch (error) {
        if (kDebugMode) {
          debugPrint("error is5 Catch Error $error");
        }
        Future.delayed(const Duration(seconds: 5), () {
          channelController?.sink.close();
          openChannel();
        });
      }
    }, (error, stack) {
      debugPrint('error is5 dd $error');
    });
  }

  void init() {
    internalController = StreamController();

    internalStream = internalController.stream.asBroadcastStream();
    openChannel();
  }

  void dispose() {
    internalController.sink.close();
    internalStream = null;

    appStreamChannel = null;
    channelController?.sink.close();
    channelController = null;
  }
}
/*
  void _initForegroundTask() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'foreground_service',
        channelName: 'Foreground Service Notification',
        channelDescription: 'This notification appears when the foreground service is running.',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
        iconData: const NotificationIconData(
          resType: ResourceType.mipmap,
          resPrefix: ResourcePrefix.ic,
          name: 'launcher',
        ),

      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: const ForegroundTaskOptions(
        interval: 5000,
        isOnceEvent: false,
        autoRunOnBoot: true,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
  }
  Future<void> _startForegroundTask() async {
    await FlutterForegroundTask.startService(
      taskId: 1,
      onTaskStarted: () async {
        _initWebSocket();
        await _updateLocationPeriodically();
      },
    );
  }*/