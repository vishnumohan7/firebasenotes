import 'package:firebasenotes/src/bloc/auth_bloc/auth_cubit.dart';
import 'package:firebasenotes/src/pages/login_page.dart';
import 'package:firebasenotes/src/pages/signup_page.dart';
import 'package:firebasenotes/src/pages/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.blue
        ),
        home: WelcomeScreen(),
      ),
    );
  }
}
