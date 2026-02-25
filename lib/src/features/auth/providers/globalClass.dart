import 'dart:async';
import 'package:flutter/foundation.dart';

class GoRouterRefreshNotifier extends ChangeNotifier {
  late final StreamSubscription _subscription;

  GoRouterRefreshNotifier(Stream stream) {
    _subscription = stream.listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}