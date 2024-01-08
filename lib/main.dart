
// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:studentprovider/provider/student_provider.dart';
import 'package:studentprovider/splash.dart';

const SAVE_KEY ='UserLoggedin';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => StudentProvider(),
      child: Myappl(),
    ),
  );
}

class Myappl extends StatelessWidget {
  const Myappl({Key ?key}):super(key: key);

  @override
  Widget build(BuildContext context) {
  
    return ChangeNotifierProvider(
       create: (context) => StudentProvider(),
      child: MaterialApp(
        title: 'Student Record',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: Splashscreen(),
        
      ),
    );
  }
}