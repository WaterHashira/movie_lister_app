import 'package:flutter/material.dart';

class DismissKeyboardOnScreenTap extends StatelessWidget {
  const DismissKeyboardOnScreenTap({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: child,
    );
  }
}
