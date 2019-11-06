import 'package:flutter/material.dart';
import 'package:patronbloc/pages/home/home-page.dart';
import 'package:patronbloc/pages/login/login-page.dart';
import 'package:patronbloc/providers/provider.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Provider( 
      child: 
        MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          initialRoute: 'login',
          routes: {
            'login': ( BuildContext context ) => LoginPage(),
            'home' : ( BuildContext context ) => HomePage()
          },
          theme: ThemeData(
            primaryColor: Colors.deepPurple
          ),
        ),
    );
    
  }
}