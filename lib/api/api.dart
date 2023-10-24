import 'package:class_selected/model/model.dart';

class CourseService {
  // Mock data
  List<Course> mockCourses = [];
  List<Teacher> mockTeachers = [];

  // 課程列表 API
  List<Course> getCourses() {
    return mockCourses;
  }

  // 授課講師列表 API
  List<Teacher> getTeachers() {
    return mockTeachers;
  }

  // 授課講師所開課程列表 API
  List<Course> getCoursesByTeacher(int teacherId) {
    return mockCourses.where((course) => course.teacherId == teacherId).toList();
  }

  // 建立新講師 API
  void createTeacher(Teacher teacher) {
    mockTeachers.add(teacher);
  }

  // 建立新課程 API
  void createCourse(Course course) {
    mockCourses.add(course);
  }

  // 更新課程內容 API
  void updateCourse(Course updatedCourse) {
    int index = mockCourses.indexWhere((course) => course.id == updatedCourse.id);
    if (index != -1) {
      mockCourses[index] = updatedCourse;
    }
  }

  // 刪除課程 API
  void deleteCourse(int courseId) {
    mockCourses.removeWhere((course) => course.id == courseId);
  }
}