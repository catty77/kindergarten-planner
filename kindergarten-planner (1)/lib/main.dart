import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
// 用蛇形命名法重命名前缀（修复提示）
import 'package:kindergarten_planner/providers/auth_provider.dart' as app_auth;
import 'package:kindergarten_planner/providers/chat_provider.dart';
import 'package:kindergarten_planner/screens/login_screen.dart';
import 'package:kindergarten_planner/screens/chat_screen.dart'; // 确保导入正确

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // 显式指定泛型类型，解决推断错误
        ChangeNotifierProvider<app_auth.AuthProvider>(
          create: (context) => app_auth.AuthProvider(),
        ),
        ChangeNotifierProvider<ChatProvider>(
          create: (context) => ChatProvider(),
        ),
      ],
      child: MaterialApp(
        home: const LoginScreen(),
        routes: {
          '/chat': (context) => const ChatScreen(), // 现在 ChatScreen 已正确定义
        },
      ),
    );
  }
}
