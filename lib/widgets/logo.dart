import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/tag-logo.png'),
            ),
            SizedBox(height: 20),
            Text(
              'Chat now!',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
