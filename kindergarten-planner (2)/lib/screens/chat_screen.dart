import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key}); // 显式声明 key 参数，符合规范

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('聊天界面'),
      ),
      body: const Center(
        child: Text('聊天功能开发中...'),
      ),
    );
  }
}
