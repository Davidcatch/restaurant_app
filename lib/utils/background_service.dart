import 'dart:ui';
import 'dart:isolate';
import 'package:workmanager/workmanager.dart';
import '../data/api/api_service.dart';
import '../utils/notification_helper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  @pragma('vm:entry-point')
  static Future<void> callbackDispatcher() async {
    Workmanager().executeTask((task, inputData) async {
      try {
        final apiService = ApiService();
        var result = await apiService.list();
        await NotificationHelper().showNotification(
          flutterLocalNotificationsPlugin,
          result,
        );

        _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
        _uiSendPort?.send(null);

        return Future.value(true);
      } catch (e) {
        return Future.value(false);
      }
    });
  }
}
