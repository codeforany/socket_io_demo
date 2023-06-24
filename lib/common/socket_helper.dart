import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  static final SocketManager sigleton = SocketManager._internal();
  SocketManager._internal();
  IO.Socket? socket;
  static SocketManager get shared => sigleton;

  void initSocket() {
    socket = IO.io('http://localhost:3001', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true
    });

    socket?.on("connect", (data) {
      if (kDebugMode) {
        print("Socket Connect Done");
      }

      updateSocketApi();
    });

    socket?.on("connect_error", (data) {
      if (kDebugMode) {
        print("Socket connect_error");
        print(data);
      }
    });

    socket?.on("error", (data) {
      if (kDebugMode) {
        print("Socket error");
        print(data);
      }
    });

    socket?.on("UpdateSocket", (data) {
      if (kDebugMode) {
        print("UpdateSocket --------------------");
        print(data);
      }

    });

    socket?.on("disconnect", (data) {
       if (kDebugMode) {
        print("Socket disconnect");
        print(data);
      }
    });

  }


  Future updateSocketApi() async {
    try {
      socket?.emit('UpdateSocket', jsonEncode({'user_id': "1"}) );
    }catch (err) {
       if (kDebugMode) {
        print(err);
      }
    }
  }
}
