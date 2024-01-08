

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentprovider/home.dart';
import 'package:studentprovider/main.dart';

import 'login.dart';


class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override void initState() {
    // Use the correct method name here
    checkUser();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color.fromARGB(255, 233, 165, 242),
      body: const Center(child: Text('STUDENTS RECORD',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color:Colors.purple)),
    ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }/*
  Future<void>gotoLogin() async{
   await Future.delayed( Duration(seconds: 3));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>Loginscreen()));
  }

Future <void>Checkuser()async{
  final _sharedpref=await SharedPreferences.getInstance();
 final _userlog= _sharedpref.getBool(SAVE_KEY);
 if(_userlog==null||_userlog==false){
  gotoLogin();
 }
 else{
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx1)=>Homescreen()));
 }
}}*/

  Future<void> gotoLogin() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => Loginscreen()));
  }

  Future<void> checkUser() async {
    final _sharedpref = await SharedPreferences.getInstance();
    final _userlog = _sharedpref.getBool(SAVE_KEY);
    if (_userlog == null || _userlog == false) {
      gotoLogin();
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx1) => Homescreen()));
    }
  }
}