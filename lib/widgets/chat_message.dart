import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    Key? key,
    required this.text,
    required this.uid,
    required this.animationController,
  }) : super(key: key);
  final String text;
  final String uid;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: animationController,
          curve: Curves.easeOut,
        ),
        child: Container(
          child: uid == '123' ? _myMessage() : _notMyMessage(),
        ),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 3,
          left: 50,
          right: 5,
        ),
        padding: EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
          color: Color(0xFF4D9EF6),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 3,
          right: 50,
          left: 5,
        ),
        padding: EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(color: Colors.black87),
        ),
        decoration: BoxDecoration(
          color: Color(0xFFe4e5e8),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
