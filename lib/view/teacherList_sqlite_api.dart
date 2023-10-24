import 'package:class_selected/api/sqlite_api.dart';
import 'package:class_selected/database/database_helper.dart';
import 'package:class_selected/model/model.dart';
import 'package:flutter/material.dart';

class TeacherListView_v2 extends StatefulWidget {
  @override
  _TeacherListView_v2State createState() => _TeacherListView_v2State();
}

class _TeacherListView_v2State extends State<TeacherListView_v2> {
  // 假定您已經建立了 DatabaseHelper 的 instance 且裡面有 fetchTeachers 和 fetchCoursesForTeacher 方法
  final dbHelper = DatabaseHelper.instance;
  final CourseService apiService = CourseService();
  List<Teacher> teachers = []; // 使用空列表先初始化

  @override
  void initState() {
    super.initState();
    // dbHelper.getTableNames();
    // print(dbHelper.getTableNames());
    _fetchTeachers(); // 當應用程式啟動時，載入教師資料
  }

  _fetchTeachers() async {
    List<Teacher> teacherList = await apiService.getTeachers();
    setState(() {
      teachers = teacherList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('教師清單', style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          itemCount: teachers.length,
          itemBuilder: (context, index) {
            return TeacherItem_v2(
                teacher: teachers[index], apiService: apiService);
          },
        ),
      ),
    );
  }
}

class TeacherItem_v2 extends StatefulWidget {
  final Teacher teacher;
  final CourseService apiService;
  TeacherItem_v2({required this.teacher, required this.apiService});

  @override
  _TeacherItem_v2State createState() => _TeacherItem_v2State();
}

class _TeacherItem_v2State extends State<TeacherItem_v2> {
  List<Course> courses = [];

  // 假定您已經建立了 DatabaseHelper 的 instance 且裡面有 fetchCoursesForTeacher 方法
  final dbHelper = DatabaseHelper.instance;

  _fetchCourses() async {
    List<Course> courseList =
        await widget.apiService.getCoursesByTeacher(widget.teacher.id);
    setState(() {
      courses = courseList;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchCourses(); // 當每一個 TeacherItem_v2 被建立時，載入該教師的課程資料
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03),
        child: ExpansionTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Text(widget.teacher.name[0].toUpperCase(),
                style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          title: Text(widget.teacher.name),
          subtitle: Text(widget.teacher.bio),
          trailing: widget.teacher.isExpanded
              ? Icon(Icons.remove, color: Colors.black)
              : Icon(Icons.add, color: Colors.black),
          onExpansionChanged: (expanded) {
            setState(() {
              widget.teacher.isExpanded = expanded;
            });
          },
          children: [
            Divider(thickness: 1),
            ...courses
                .map((course) => Container(
                      // decoration: BoxDecoration(
                      //   border: Border(
                      //       bottom: BorderSide(color: Colors.grey, width: 0.5)),
                      // ),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        leading: Icon(Icons.calendar_today),
                        title: Text(course.courseName),
                        subtitle: Text(course.classTime),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          // Navigate to course details page here
                        },
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
