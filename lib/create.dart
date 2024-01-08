import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:studentprovider/datamodel.dart';

import 'package:studentprovider/home.dart';
import 'package:studentprovider/provider/student_provider.dart';


class Createscreen extends StatefulWidget {
  const Createscreen({Key? key}) : super(key: key);

  @override
  State<Createscreen> createState() => _CreatescreenState();
}

class _CreatescreenState extends State<Createscreen> {
  final name1controller = TextEditingController();
  final age1controller = TextEditingController();
  final div1controller = TextEditingController();
  final rollno1controller = TextEditingController();
  String _selectedImagePath = '';
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Student')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formkey,
            child: Consumer<StudentProvider>(
              builder: (context, studentProvider, child) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: TextFormField(
                        controller: name1controller,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Student Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Value is empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    TextFormField(
                      controller: age1controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Age',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Value is empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: div1controller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Class',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Value is empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: rollno1controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Roll no',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Value is empty';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: _pickImage,
                      child: Text('Pick Image'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          await onAddbutton(studentProvider);
                          showDialog(
                            context: context,
                            builder: (ctx1) {
                              return AlertDialog(
                                title: const Text('Data saved'),
                                content: const Text('Student data saved successfully'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(builder: (ctx) => Homescreen()),
                                        (route) => false,
                                      );
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          print('Data empty');
                        }
                      },
                      child: const Text('Add Student'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImagePath = pickedFile.path ?? '';
      });
    }
  }

  Future<void> onAddbutton(StudentProvider studentProvider) async {
    final _name = name1controller.text.trim();
    final _age = age1controller.text.trim();
    final _div = div1controller.text.trim();
    final _rollno = rollno1controller.text.trim();
    if (_name.isEmpty || _age.isEmpty || _div.isEmpty || _rollno.isEmpty) {
      return;
    }

    final student = StudentModel(
      name: _name,
      age: _age,
      div: _div,
      rollno: _rollno,
      imagepath: _selectedImagePath,
    );

    await studentProvider.addStudent(student);
  }
}
