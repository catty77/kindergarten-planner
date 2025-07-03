import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kindergarten_planner/models/lesson.dart';

class LessonProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Lesson> _lessons = [];

  List<Lesson> get lessons => _lessons;

  List<Lesson> getLessonsByDate(DateTime date) {
    final dateString =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    return _lessons
        .where((lesson) =>
            '${lesson.date.year}-${lesson.date.month.toString().padLeft(2, '0')}-${lesson.date.day.toString().padLeft(2, '0')}' ==
            dateString)
        .toList();
  }

  List<Lesson> getLessonsByDateAndClass(DateTime date, String classroom) {
    final dateString =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    return _lessons
        .where((lesson) =>
            '${lesson.date.year}-${lesson.date.month.toString().padLeft(2, '0')}-${lesson.date.day.toString().padLeft(2, '0')}' ==
                dateString &&
            lesson.classroom == classroom)
        .toList();
  }

  Future<void> loadLessons(DateTime date, String classroom) async {
    try {
      final dateString =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

      final QuerySnapshot snapshot = await _firestore
          .collection('lessons')
          .where('date', isEqualTo: dateString)
          .where('classroom', isEqualTo: classroom)
          .get();

      _lessons = snapshot.docs
          .map((doc) =>
              Lesson.fromFirestore(doc.data() as Map<String, dynamic>, doc.id))
          .toList();

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addLesson(Lesson lesson) async {
    try {
      final dateString =
          '${lesson.date.year}-${lesson.date.month.toString().padLeft(2, '0')}-${lesson.date.day.toString().padLeft(2, '0')}';

      await _firestore.collection('lessons').add({
        'date': dateString,
        'classroom': lesson.classroom,
        'topic': lesson.topic,
        'task': lesson.task,
        'notes': lesson.notes,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // 重新加载课程数据
      await loadLessons(lesson.date, lesson.classroom);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateLesson(Lesson lesson) async {
    try {
      await _firestore.collection('lessons').doc(lesson.id).update({
        'topic': lesson.topic,
        'task': lesson.task,
        'notes': lesson.notes,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // 重新加载课程数据
      await loadLessons(lesson.date, lesson.classroom);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteLesson(Lesson lesson) async {
    try {
      await _firestore.collection('lessons').doc(lesson.id).delete();

      // 从本地列表中移除
      _lessons.removeWhere((item) => item.id == lesson.id);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
