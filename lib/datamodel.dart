class StudentModel {
  int? id;
  final String name;
  final String age;
  final String div;
  final String rollno;
  final String imagepath;

  StudentModel({
    required this.name,
    required this.age,
    required this.div,
    required this.rollno,
    required this.imagepath,
    this.id,
  });

  factory StudentModel.fromMap(Map<String, Object?> map) {
    return StudentModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      age: map['age'] as String,
      div: map['div'] as String,
      rollno: map['rollno'] as String,
      imagepath: map['imagepath'] as String,
    );
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'div': div,
      'rollno': rollno,
      'imagepath': imagepath,
    };
  }
}