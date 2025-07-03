import 'package:cloud_firestore/cloud_firestore.dart';

class Lesson {
  final String id;
  final DateTime date;
  final String classroom;
  final String topic;
  final String task;
  final String notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Lesson({
    required this.id,
    required this.date,
    required this.classroom,
    required this.topic,
    required this.task,
    required this.notes,
    this.createdAt,
    this.updatedAt,
  });

  // 从Firestore数据创建Lesson对象
  factory Lesson.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Lesson(
      id: documentId,
      date: _parseDate(data['date']),
      classroom: data['classroom'] ?? '',
      topic: data['topic'] ?? '',
      task: data['task'] ?? '',
      notes: data['notes'] ?? '',
      createdAt: data['createdAt'] != null 
        ? (data['createdAt'] as Timestamp).toDate() 
        : null,
      updatedAt: data['updatedAt'] != null 
        ? (data['updatedAt'] as Timestamp).toDate() 
        : null,
    );
  }

  // 将日期字符串解析为DateTime
  static DateTime _parseDate(String dateString) {
    final parts = dateString.split('-');
    return DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
  }

  // 创建一个新的Lesson对象，复制当前对象的值并更新指定的字段
  Lesson copyWith({
    String? id,
    DateTime? date,
    String? classroom,
    String? topic,
    String? task,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Lesson(
      id: id ?? this.id,
      date: date ?? this.date,
      classroom: classroom ?? this.classroom,
      topic: topic ?? this.topic,
      task: task ?? this.task,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // 将Lesson对象转换为Map，用于存储到Firestore
  Map<String, dynamic> toMap() {
    return {
      'date': '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
      'classroom': classroom,
      'topic': topic,
      'task': task,
      'notes': notes,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}    