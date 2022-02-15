// To parse this JSON data, do
//
//     final messageResponse = messageResponseFromJson(jsonString);

import 'dart:convert';

MessageResponse messageResponseFromJson(String str) =>
    MessageResponse.fromJson(json.decode(str));

String messageResponseToJson(MessageResponse data) =>
    json.encode(data.toJson());

class MessageResponse {
  MessageResponse({
    required this.ok,
    required this.msg,
    required this.messages,
  });

  bool ok;
  String msg;
  List<Message> messages;

  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      MessageResponse(
        ok: json["ok"],
        msg: json["msg"],
        messages: List<Message>.from(
            json["messages"].map((x) => Message.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
      };
}

class Message {
  Message({
    required this.from,
    required this.to,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
  });

  String from;
  String to;
  String message;
  DateTime createdAt;
  DateTime updatedAt;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        from: json["from"],
        to: json["to"],
        message: json["message"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "message": message,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
