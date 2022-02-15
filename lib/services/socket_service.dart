import 'package:chat/global/enviroment.dart';
import 'package:chat/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting,
}

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket? _socket;

  ServerStatus get serverStatus => _serverStatus;

  IO.Socket? get socket => _socket;

  final bool isConnected = false;

  void Function(String event, [dynamic data])? get emit => _socket?.emit;

  void connect() async {
    final token = await AuthService.getToken();
    _socket = IO.io(
        Enviroments.socketUrl,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableForceNew()
            .setExtraHeaders({'x-token': token})
            .build());
    _socket?.onConnect((_) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    _socket?.onDisconnect((_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }

  void disconnect() {
    _socket?.disconnect();
  }
  // void on(String s, Null Function(dynamic payload) param1) {}
}
