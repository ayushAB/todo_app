import 'package:flutter/material.dart';
import 'package:todo_app/constants/styles.dart';

class AppButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;

  const AppButton({
    Key? key,
    required this.buttonText,
    required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: AppStyle.AppButtonStyle(),
      child: Text(buttonText),
    );
  }
}
