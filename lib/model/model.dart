class Course {
  final int id;
  final String courseName;
  final String description;
  final String classTime;
  final int teacherId;

  Course({
    required this.id,
    required this.courseName,
    required this.description,
    required this.classTime,
    required this.teacherId,
  });

  Map<String, dynamic> toMapWithTeacherId() {
    return {
      'courseName': courseName,
      'description': description,
      'classTime': classTime,
      'teacherId': teacherId,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'],
      courseName: map['courseName'],
      description: map['description'],
      classTime: map['classTime'],
      teacherId: map['teacherId'],
    );
  }
}

class Teacher {
  final int id;
  final String name;
  final String title; // 新增這行
  final String bio;
  final String profileImage;
  bool isExpanded;

  Teacher(
      {required this.id,
      required this.name,
      required this.title, // 新增這行
      required this.bio,
      required this.profileImage,
      this.isExpanded = false});

  // Convert a Teacher into a Map. The keys must correspond to the names of the columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'title': title,
      'bio': bio,
      'profileImage': profileImage,
    };
  }

  factory Teacher.fromMap(Map<String, dynamic> map) {
    return Teacher(
      id: map['id'],
      name: map['name'],
      title: map['title'],
      bio: map['bio'],
      profileImage: map['profileImage'],
    );
  }
}
