import 'package:flutter/foundation.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatProvider extends ChangeNotifier {
  types.Room? _currentRoom;
  final List<types.Message> _messages = [];

  List<types.Message> get messages => _messages;
  types.Room? get currentRoom => _currentRoom;

  Future<void> createChatRoom(String targetUserId) async {
    try {
      final user = types.User(id: targetUserId);
      _currentRoom = await FirebaseChatCore.instance.createRoom(user);
      notifyListeners();
    } catch (e) {
      debugPrint('创建房间失败：$e');
    }
  }

  void listenToMessages() {
    if (_currentRoom == null) return;
    FirebaseChatCore.instance.messages(_currentRoom!).listen((newMessages) {
      _messages.clear();
      _messages.addAll(newMessages);
      notifyListeners();
    });
  }

  void sendMessage(String text) {
    if (_currentRoom == null) return;
    final message = types.PartialText(text: text);
    FirebaseChatCore.instance.sendMessage(message, _currentRoom!.id);
  }
}
