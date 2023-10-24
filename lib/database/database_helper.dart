import 'package:class_selected/model/model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _dbName = 'myDatabase.db';
  static final _dbVersion = 1;
  static final _tableName = 'teachers';

  static const tableteacher = """
    CREATE TABLE IF NOT EXISTS teachers (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        title TEXT NOT NULL,  
        bio TEXT NOT NULL,
        profileImage TEXT NOT NULL
      );""";
  static const tablecourses = """
  CREATE TABLE IF NOT EXISTS courses (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
        courseName TEXT,
        description TEXT,
        classTime TEXT,
        teacherId INTEGER,
        FOREIGN KEY (teacherId) REFERENCES teachers(id) ON DELETE CASCADE
      );""";

  // making it a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(path,
        version: _dbVersion, onCreate: _onCreate, onUpgrade: _onUpgrade // 加入此行
        );
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(tableteacher);
      await db.execute(tablecourses);
      await db.insert('teachers', {
        'name': 'Albert Flores',
        'title': 'Demonstrator',
        'bio': 'Bio for Albert',
        'profileImage': 'Path_to_image'
      });
      await db.insert('teachers', {
        'name': 'Floyd Miles',
        'title': 'Lecturer',
        'bio': 'Bio for Floyd',
        'profileImage': 'Path_to_image'
      });
      await db.insert('courses', {
        'courseName': '基礎程式設計',
        'description': '學習程式的基礎',
        'classTime': '每周二，10:00-12:00',
        'teacherId': 1
      });
      await db.insert('courses', {
        'courseName': '高階程式設計',
        'description': '深入程式的核心',
        'classTime': '每周四，14:00-16:00',
        'teacherId': 1
      });
    }
    // 若未來有第三版、第四版等，可以在此加入更多的條件判斷
    // String path = join(await getDatabasesPath(), _dbName);
    // return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    // await db.execute('''
    //   CREATE TABLE $_tableName (
    //     id INTEGER PRIMARY KEY,
    //     name TEXT NOT NULL,
    //     bio TEXT NOT NULL,
    //     profileImage TEXT
    //   )
    //   ''');

    await db.execute(tableteacher);
    await db.execute(tablecourses);
    // await db.execute('''
    //   CREATE TABLE teachers (
    //     id INTEGER PRIMARY KEY,
    //     name TEXT NOT NULL,
    //     title TEXT NOT NULL
    //   )
    //   ''');
    // await db.execute('''
    //   CREATE TABLE courses(
    //     id INTEGER PRIMARY KEY AUTOINCREMENT,
    //     courseName TEXT,
    //     description TEXT,
    //     classTime TEXT,
    //     teacherId INTEGER,
    //     FOREIGN KEY (teacherId) REFERENCES teachers(id) ON DELETE CASCADE
    //   )
    //   ''');

    // // 插入初始資料
    // var teacher1 = {
    //   'id': 1,
    //   'name': 'John Doe',
    //   'bio': 'Bio for John',
    //   'profileImage': 'path/to/image1.png'
    // };
    // var teacher2 = {
    //   'id': 2,
    //   'name': 'Jane Smith',
    //   'bio': 'Bio for Jane',
    //   'profileImage': 'path/to/image2.png'
    // };
    // await db.insert(_tableName, teacher1);
    // await db.insert(_tableName, teacher2);
    // 插入初始數據
    await db.insert('teachers', {
      'name': 'Albert Flores',
      'title': 'Demonstrator',
      'bio': 'Bio for Albert',
      'profileImage': 'Path_to_image'
    });
    await db.insert('teachers', {
      'name': 'Floyd Miles',
      'title': 'Lecturer',
      'bio': 'Bio for Floyd',
      'profileImage': 'Path_to_image'
    });
    await db.insert('courses', {
      'courseName': '基礎程式設計',
      'description': '學習程式的基礎',
      'classTime': '每周二，10:00-12:00',
      'teacherId': 1
    });
    await db.insert('courses', {
      'courseName': '高階程式設計',
      'description': '深入程式的核心',
      'classTime': '每周四，14:00-16:00',
      'teacherId': 1
    });
  }

  // Insert a teacher into the database
  Future<int> insert(Teacher teacher) async {
    Database db = await instance.database;
    return await db.insert(_tableName, teacher.toMap());
  }

  // Fetch all teachers
  Future<List<Teacher>> fetchTeachers() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    print(maps);
    return List.generate(maps.length, (i) {
      return Teacher(
        id: maps[i]['id'],
        name: maps[i]['name'],
        title: maps[i]['title'],
        bio: maps[i]['bio'],
        profileImage: maps[i]['profileImage'],
      );
    });
  }

  Future<int> insertCourse(Course course) async {
    Database db = await instance.database;
    return await db.insert('courses', course.toMapWithTeacherId());
  }

  Future<List<Course>> fetchCoursesForTeacher(int teacherId) async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db
        .query('courses', where: 'teacherId = ?', whereArgs: [teacherId]);

    return List.generate(maps.length, (i) {
      return Course.fromMap(maps[i]);
    });
  }

  Future<List<String>> getTableNames() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> tables =
        await db.rawQuery('SELECT name FROM sqlite_master WHERE type="table"');
    return List.generate(tables.length, (i) {
      print("tablename ${tables[i]['name']}");
      return tables[i]['name'];
    });
  }

  // 查詢給定表中的所有行。
  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // 根據指定列和值查詢行。
  Future<List<Map<String, dynamic>>> queryRowsByColumn(
      String table, String column, dynamic value) async {
    Database db = await instance.database;
    return await db.query(table, where: '$column = ?', whereArgs: [value]);
  }

 // 插入資料到指定的表格
  Future<int> insertToSqlite(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  // 更新指定表格的資料
  Future<int> update(String table, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.update(table, row, where: 'id = ?', whereArgs: [row['id']]);
  }

  // 從指定表格刪除資料
  Future<int> delete(String table, int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }


}
