import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? _user;
  static const String defaultRole = 'teacher'; // 修复常量定义
  String? _userRole;

  User? get user => _user;
  String get userRole => _userRole ?? defaultRole;

  Future<void> signInWithPhone(String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (credential) async {
          final userCredential =
              await _firebaseAuth.signInWithCredential(credential);
          _user = userCredential.user;
          _userRole = defaultRole; // 引用已定义的常量
          notifyListeners();
        },
        verificationFailed: (e) => debugPrint(e.message),
        codeSent: (verificationId, resendToken) {},
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } catch (e) {
      debugPrint('登录失败：$e');
    }
  }

  void signOut() {
    _firebaseAuth.signOut();
    _user = null;
    _userRole = null;
    notifyListeners();
  }
}
