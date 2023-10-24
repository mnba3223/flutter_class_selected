import 'package:class_selected/database/database_helper.dart';
import 'package:class_selected/model/model.dart';
import 'package:sqflite/sqflite.dart';

class CourseService {
  final dbHelper = DatabaseHelper.instance;

  // 課程列表 API (Read)
  Future<List<Course>> getCourses() async {
    final courseMaps = await dbHelper.queryAllRows('courses');
    return List.generate(courseMaps.length, (i) {
      return Course.fromMap(courseMaps[i]);
    });
  }

  // 授課講師列表 API (Read)
  Future<List<Teacher>> getTeachers() async {
    final teacherMaps = await dbHelper.queryAllRows('teachers');
    return List.generate(teacherMaps.length, (i) {
      return Teacher.fromMap(teacherMaps[i]);
    });
  }

  // 授課講師所開課程列表 API (Read)
  Future<List<Course>> getCoursesByTeacher(int teacherId) async {
    final courseMaps =
        await dbHelper.queryRowsByColumn('courses', 'teacherId', teacherId);
    return List.generate(courseMaps.length, (i) {
      return Course.fromMap(courseMaps[i]);
    });
  }

  // 建立新講師 API (Create)
  Future<void> createTeacher(Teacher teacher) async {
    await dbHelper.insertToSqlite('teachers', teacher.toMap());
  }

  // 建立新課程 API (Create)
  Future<void> createCourse(Course course) async {
    await dbHelper.insertToSqlite('courses', course.toMapWithTeacherId());
  }

  // 更新課程內容 API (Update)
  Future<void> updateCourse(Course course) async {
    await dbHelper.update('courses', course.toMapWithTeacherId());
  }

  // 刪除課程 API (Delete)
  Future<void> deleteCourse(int courseId) async {
    await dbHelper.delete('courses', courseId);
  }
}
