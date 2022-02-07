import 'package:flutter/material.dart';

class BtnBlue extends StatelessWidget {
  const BtnBlue({
    Key? key,
    required this.text,
    required this.onPress,
  }) : super(key: key);
  final String text;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(fontSize: 20),
        elevation: 2,
        shape: StadiumBorder(),
      ),
      onPressed: onPress,
      child: Container(
        width: double.infinity,
        height: 45,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
