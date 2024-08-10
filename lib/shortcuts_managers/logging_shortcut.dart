import 'dart:io';

import 'package:flutter/material.dart';

class LoggingShortcutManager extends ShortcutManager {
  @override
  KeyEventResult handleKeypress(BuildContext context, KeyEvent event) {
    final KeyEventResult result = super.handleKeypress(context, event);
    if (result == KeyEventResult.handled) {
      throw const SocketException(
          "SocketException: OS Error: Connection refused, errno = 111, address = localhost, port = 60703");
    }
    return result;
  }
}
