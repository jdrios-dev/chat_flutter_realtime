import 'package:chat/global/enviroment.dart';
import 'package:chat/models/messages_response.dart';
import 'package:chat/models/user.dart';
import 'package:chat/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {
  late User userTo;

  Future getChat(String userId) async {
    final resp = await http.get(
      Uri.parse('${Enviroments.apiUrl}/messages/$userId'),
      headers: {
        'Content-type': 'application/json',
        'x-token': await AuthService.getToken()
      },
    );
    final messageResp = messageResponseFromJson(resp.body);
    return messageResp.messages;
  }
}
