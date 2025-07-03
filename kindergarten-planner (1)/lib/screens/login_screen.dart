import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('登录')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(hintText: '输入手机号'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final phone = _phoneController.text.trim();
                if (phone.isEmpty) return;

                await FirebaseAuth.instance.verifyPhoneNumber(
                  phoneNumber: phone,
                  verificationCompleted: (cred) async {
                    await FirebaseAuth.instance.signInWithCredential(cred);
                    if (!mounted) return;
                    Navigator.pushNamed(context, '/chat');
                  },
                  verificationFailed: (e) => debugPrint(e.message),
                  codeSent: (id, token) {
                    if (!mounted) return;
                    // 可跳转验证码页面
                  },
                  codeAutoRetrievalTimeout: (id) {},
                );
              },
              child: const Text('获取验证码'),
            ),
          ],
        ),
      ),
    );
  }
}
