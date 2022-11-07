import 'dart:async';

import 'package:flutter/material.dart';

class Debounce {
  Timer? _timer;
  final int milliseconds;

  Debounce({required this.milliseconds});

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }

    _timer = Timer(
      Duration(milliseconds: milliseconds),
      action,
    );
  }
}
