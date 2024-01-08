import 'package:flutter/foundation.dart';
import 'package:studentprovider/datamodel.dart';
import 'package:studentprovider/db/db_function.dart';

class StudentProvider extends ChangeNotifier {
  late DbFunction _dbFunction;

  List<StudentModel> _students = [];
  List<StudentModel> get students => _students;

  StudentProvider() {
    _dbFunction = DbFunction();
    initialize();
  }

  Future<void> initialize() async {
    await _dbFunction.initializeDatabase();
    await getAllStudents();
  }

  Future<void> addStudent(StudentModel value) async {
    final studentData = value.toMap();
    final _id = await _dbFunction.addStudent(studentData);
    value.id = _id;
    await getAllStudents();
  }

  Future<void> getAllStudents() async {
    final values = await _dbFunction.getAllStudents();
    _students.clear();
    values.forEach((map) {
      final student = StudentModel.fromMap(map);
      _students.add(student);
    });
    notifyListeners();
  }

  Future<void> deleteStudent(int id) async {
    await _dbFunction.deleteStudent(id);
    await getAllStudents();
  }

  Future<void> updateStudent(
      String newname, String newage, String newdiv, String newrollno, int id) async {
    final studentData = {
      'name': newname,
      'age': newage,
      'div': newdiv,
      'rollno': newrollno,
    };
    await _dbFunction.updateStudent(studentData, id);
    await getAllStudents();
  }

  Future<List<StudentModel>> searchStudents(String searchQuery) async {
    final results = await _dbFunction.searchStudents(searchQuery);

    return results.map((map) => StudentModel.fromMap(map)).toList();
  }

  // Added method to clear user data
  void clearUserData() {
    _students.clear();
    notifyListeners();
  }
}
