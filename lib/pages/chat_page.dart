import 'dart:io';

import 'package:chat/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isWriting = false;

  List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  maxRadius: 14,
                  child: Text(
                    'Te',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  backgroundColor: Colors.blue[200],
                ),
                SizedBox(height: 5),
                Text(
                  'Test Name',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  reverse: true,
                  itemBuilder: (_, i) => _messages[i],
                  itemCount: _messages.length,
                ),
              ),
              Divider(
                height: 1,
              ),
              Container(
                child: _inputChat(),
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputChat() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmit,
              onChanged: (String text) {
                setState(() {
                  if (text.trim().length > 0) {
                    _isWriting = true;
                  } else {
                    _isWriting = false;
                  }
                });
              },
              decoration: InputDecoration.collapsed(hintText: 'Send Message'),
              focusNode: _focusNode,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: Platform.isIOS
                ? CupertinoButton(
                    onPressed: _isWriting
                        ? () => _handleSubmit(_textController.text.trim())
                        : null,
                    child: Text('Send'),
                  )
                : IconTheme(
                    data: IconThemeData(
                      color: Colors.blue[400],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: _isWriting
                          ? () => _handleSubmit(_textController.text.trim())
                          : null,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  _handleSubmit(String text) {
    if (text.length == 0) {
      return;
    }
    
    _focusNode.requestFocus();
    _textController.clear();

    final newMessage = ChatMessage(
      text: text,
      uid: '1234',
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500),
      ),
    );

    _messages.insert(0, newMessage);
    newMessage.animationController.forward();

    setState(() {
      _isWriting = false;
    });
  }

  @override
  void dispose() {
    // TODO: off del socket
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
