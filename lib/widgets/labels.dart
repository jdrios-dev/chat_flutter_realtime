import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  const Labels({
    Key? key,
    required this.routeName,
    required this.mainLabel,
    required this.linkLabel,
  }) : super(key: key);

  final String routeName;
  final String mainLabel;
  final String linkLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            mainLabel,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, routeName);
            },
            child: Text(
              linkLabel,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 60),
          Text(
            'Visit terms and conditions',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
