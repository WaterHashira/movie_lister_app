import 'package:flutter/material.dart';
import 'package:movie_lister_app/util/globals.dart';

class ErrorSnackbar {
  static const _defaultSnackBarDuration = Duration(seconds: 2);

//error snackbar caller
  void showErrorSnackBar(
    String? text, {
    Duration duration = _defaultSnackBarDuration,
  }) {
    _showSnackBar(
      text,
      duration: duration,
    );
  }

//forging snackbar
  void _showSnackBar(
    String? text, {
    Duration duration = _defaultSnackBarDuration,
  }) {
    if (text == null) return;

    Globals.scaffoldMessengerKey.currentState
      ?..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          content: Text(text),
          backgroundColor: Colors.red[400],
          clipBehavior: Clip.none,
          padding: const EdgeInsets.all(10),
          duration: duration,
        ),
      );
  }
}
