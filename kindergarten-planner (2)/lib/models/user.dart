class UserModel {
  final String uid;
  final String name;
  final String role;
  final String phone;

  UserModel({
    required this.uid,
    required this.name,
    required this.role,
    required this.phone,
  });

  // 从Firestore数据创建UserModel对象
  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      uid: data['uid'] ?? '',
      name: data['name'] ?? '',
      role: data['role'] ?? '',
      phone: data['phone'] ?? '',
    );
  }

  // 将UserModel对象转换为Map，用于存储到Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'role': role,
      'phone': phone,
    };
  }
}    