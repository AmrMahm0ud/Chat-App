import 'package:chat_app_version2/screens/auth_screen.dart';
import 'package:chat_app_version2/widgets/auth/auth_form.dart';
import 'package:flutter/material.dart';
import './screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
        )
      ),
      home: StreamBuilder(stream: FirebaseAuth.instance.onAuthStateChanged, builder:(ctx , userSnapshot) {
        if(userSnapshot.hasData){
           return ChatScreen();
        }
        return AuthScreen();
      }),
    );
  }
}
