import 'package:flutter/foundation.dart';
import 'package:workmanager/workmanager.dart';
import '../utils/background_service.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledNews(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('Scheduling News Activated');
      notifyListeners();

      final now = DateTime.now();
      var target = DateTime(now.year, now.month, now.day, 11, 0, 0);

      if (target.isBefore(now)) target = target.add(const Duration(days: 1));

      final initialDelay = target.difference(now);

      await Workmanager().registerPeriodicTask(
        "1",
        "simpleTask",
        frequency: const Duration(hours: 24),
        initialDelay: initialDelay,
        existingWorkPolicy: ExistingPeriodicWorkPolicy.update,
        constraints: Constraints(networkType: NetworkType.connected),
      );
      return true;
    } else {
      print('Scheduling News Canceled');
      notifyListeners();
      await Workmanager().cancelAll();
      return false;
    }
  }
}
