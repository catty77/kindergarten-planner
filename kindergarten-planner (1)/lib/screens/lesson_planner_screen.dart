import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Lesson {
  final String id;
  final String title;
  Lesson({required this.id, required this.title});
}

class LessonPlannerScreen extends StatefulWidget {
  const LessonPlannerScreen({super.key});

  @override
  State<LessonPlannerScreen> createState() => _LessonPlannerScreenState();
}

class _LessonPlannerScreenState extends State<LessonPlannerScreen> {
  final List<Lesson> _lessons = [Lesson(id: '1', title: '幼儿园课程1')];

  void _deleteItem(String id) {
    setState(() => _lessons.removeWhere((lesson) => lesson.id == id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('课程规划')),
      body: ListView.builder(
        itemCount: _lessons.length,
        itemBuilder: (context, index) {
          final lesson = _lessons[index];
          return Slidable(
            key: Key(lesson.id),
            // 右侧滑动操作（替代 secondaryActions）
            endActionPane: ActionPane(
              motion: const ScrollMotion(), // 滑动动画
              children: [
                // 替代 IconSlideAction
                SlidableAction(
                  onPressed: (context) => _deleteItem(lesson.id),
                  backgroundColor: Colors.red,
                  icon: Icons.delete,
                  label: '删除', // 替代 caption
                ),
              ],
            ),
            child: ListTile(
              title: Text(lesson.title),
            ),
          );
        },
      ),
    );
  }
}
