import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studentprovider/create.dart';

import 'package:studentprovider/student.dart';
import 'datamodel.dart';
import 'login.dart';
import 'dart:io';
import 'provider/student_provider.dart'; // Import the StudentProvider

enum LayoutType {
  ListView,
  GridView,
}

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  LayoutType _layoutType = LayoutType.ListView;

  @override
  Widget build(BuildContext context) {
    var studentProvider = Provider.of<StudentProvider>(context); // Access the StudentProvider

    return Scaffold(
      appBar: AppBar(
        title: const Text('User'),
        actions: [
          PopupMenuButton<LayoutType>(
            onSelected: (layout) {
              setState(() {
                _layoutType = layout;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<LayoutType>>[
              const PopupMenuItem<LayoutType>(
                value: LayoutType.ListView,
                child: Text('List View'),
              ),
              const PopupMenuItem<LayoutType>(
                value: LayoutType.GridView,
                child: Text('Grid View'),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx1) {
                  return AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you want to logout'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          signout(context);
                        },
                        child: const Text('yes'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
        leading: Container(
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.all(4),
          child: const CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage('assets/images/rose.jpg'),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => Createscreen()));
        },
      ),
      body: SafeArea(
        child: _buildBody(studentProvider),
      ),
    );
  }

  Widget _buildBody(StudentProvider studentProvider) {
    if (studentProvider.students.isEmpty) {
      return const Center(
        child: Text('No items found'),
      );
    }

    if (_layoutType == LayoutType.ListView) {
      return ListView.separated(
        itemCount: studentProvider.students.length,
        separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey),
        itemBuilder: (context, index) {
          final data = studentProvider.students[index];
          return ListTile(
            title: Text(data.name),
            leading: _buildImageWidget(data, width: 60, height: 60),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => Studentscreen(
                  name: data.name,
                  age: data.age,
                  id: data.id,
                  div: data.div,
                  rollno: data.rollno,
                ),
              ));
            },
          );
        },
      );
    } else {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: studentProvider.students.length,
        itemBuilder: (context, index) {
          final dat = studentProvider.students[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => Studentscreen(
                  name: dat.name,
                  age: dat.age,
                  id: dat.id,
                  div: dat.div,
                  rollno: dat.rollno,
                ),
              ));
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildImageWidget(dat, width: 100, height: 100),
                  const SizedBox(height: 8),
                  Text(dat.name),
                ],
              ),
              elevation: 4,
              margin: EdgeInsets.all(8),
            ),
          );
        },
      );
    }
  }

  Widget _buildImageWidget(StudentModel student, {double width = 60, double height = 60}) {
    if (student.imagepath != null && student.imagepath.isNotEmpty) {
      return Image.file(
        File(student.imagepath),
        width: width,
        height: height,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        'assets/images/student.jpg',
        width: width,
        height: height,
        fit: BoxFit.cover,
      );
    }
  }

  signout(BuildContext ctx) async {
    // Use the studentProvider to clear the user data or any necessary actions
    final studentProvider = Provider.of<StudentProvider>(context, listen: false);
    studentProvider.clearUserData();

    Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx1) => Loginscreen()), (route) => false);
  }
}
