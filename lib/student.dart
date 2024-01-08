import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentprovider/provider/student_provider.dart';
import 'home.dart';

class Studentscreen extends StatefulWidget {
  final String name;
  final String age;
  final int? id;
  final String div;
  final String rollno;

  Studentscreen({
    Key? key,
    required this.name,
    required this.age,
    required this.id,
    required this.div,
    required this.rollno,
  }) : super(key: key);

  @override
  _StudentscreenState createState() => _StudentscreenState();
}

class _StudentscreenState extends State<Studentscreen> {
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController divController;
  late TextEditingController rollnoController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    ageController = TextEditingController(text: widget.age);
    divController = TextEditingController(text: widget.div);
    rollnoController = TextEditingController(text: widget.rollno);
  }

  @override
  Widget build(BuildContext context) {
    final studentProvider = Provider.of<StudentProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.name)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Row(
                      children: [
                        Text('Student name:'),
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Student name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Value empty';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text('Age:'),
                      TextFormField(
                        controller: ageController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Age',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Value empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  Row(
                    children: [
                      Text('Class:'),
                      TextFormField(
                        controller: divController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Class',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Value empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  Row(
                    children: [
                      Text('Roll no:'),
                      TextFormField(
                        controller: rollnoController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Roll no',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Value empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                    width: 20,
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (ctx) => Homescreen()),
                                  (route) => false);
                        },
                        child: Text('OK'),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx1) {
                              return AlertDialog(
                                title: Text('Delete'),
                                content: Text('Do you want to delete this item'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx1).pop();
                                    },
                                    child: Text('Close'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      studentProvider.deleteStudent(widget.id!);
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(builder: (ctx) => Homescreen()),
                                              (route) => false);
                                    },
                                    child: Text('Yes'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text('DELETE'),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx1) {
                              return AlertDialog(
                                title: Text('Update'),
                                content: Text('Do you want to update this item'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx1).pop();
                                    },
                                    child: Text('Close'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      studentProvider.updateStudent(
                                        nameController.text.trim(),
                                        ageController.text.trim(),
                                        divController.text.trim(),
                                        rollnoController.text.trim(),
                                        widget.id!,
                                      );
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(builder: (ctx) => Homescreen()),
                                              (route) => false);
                                    },
                                    child: Text('Yes'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text('UPDATE'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
