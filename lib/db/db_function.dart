import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbFunction {
  late Database _db;

  Future<void> initializeDatabase() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'student.db'),
      version: 1,
      onCreate: (Database db, int version) {
        db.execute(
            'CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, age TEXT, div TEXT, rollno TEXT, imagepath TEXT)');
      },
    );
  }

  Future<int> addStudent(Map<String, dynamic> studentData) async {
    return await _db.insert('student', studentData);
  }

  Future<List<Map<String, dynamic>>> getAllStudents() async {
    return await _db.query('student');
  }

  Future<void> deleteStudent(int id) async {
    await _db.delete('student', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateStudent(Map<String, dynamic> studentData, int id) async {
    await _db.update('student', studentData, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> searchStudents(String searchQuery) async {
    return await _db.query(
      'student',
      where: 'name LIKE ?',
      whereArgs: ['%$searchQuery%'],
    );
  }
}