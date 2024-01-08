

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentprovider/main.dart';


import 'home.dart';

class Loginscreen extends StatelessWidget {
 Loginscreen({super.key});
final usernamecontroller=TextEditingController();
final passwordcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body:SafeArea (
         child:Padding(
          padding: const EdgeInsets.all(25.0),
        
       child:Card(
        child:Padding(
          padding: const EdgeInsets.all(15.0),
           
                
          child: Column(
            
            children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: TextFormField(
                controller: usernamecontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Username',
                ),
              ),
            ),
         
            TextFormField(
              controller:passwordcontroller ,
              obscureText: true,
               decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
               ),
              
               
            ),
              SizedBox(
              height: 20,
              width: 20,
            ),
          ElevatedButton(onPressed: (){
            
            checklogin(context);
          },
           child:
           Text('LOGIN'))
          ],),
        ),
      )
    ),),);
  }
  void checklogin(BuildContext ctx)async
  {
    final _username=usernamecontroller.text;
    final _password=passwordcontroller.text;
    if(_username=='user'){
if(_password=='user'){
  final _sharedprefs=await SharedPreferences.getInstance();
 await  _sharedprefs.setBool(SAVE_KEY, true);
 Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (ctx1)=>Homescreen()));
}
else{
//snack bar
ScaffoldMessenger.of(ctx).showSnackBar(
  SnackBar(
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(10),
    content: Text('password incorrect'),
  )
);



}

    }
      else{
ScaffoldMessenger.of(ctx).showSnackBar(
  SnackBar(
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(10),
    content: Text('username incorrect'),
  )
);
    }
  }}
