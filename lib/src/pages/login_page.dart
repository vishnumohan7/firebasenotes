import 'package:firebasenotes/src/bloc/auth_bloc/auth_cubit.dart';
import 'package:firebasenotes/src/pages/home_page.dart';
import 'package:firebasenotes/src/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(31, 29, 43, 1),
        body: Form(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0.0, left: 30, right: 30),
                  child: Image.asset("assets/images/illus.png",height: 140,),
                ),
                Text(
                  "Login Here",
                  style: GoogleFonts.montserratAlternates(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _emailController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(

                      labelText: "Email",
                      focusColor: Colors.white,
                      labelStyle: GoogleFonts.mulish(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(color: Colors.white))),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),

                  controller: _passwordController,
                  decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: GoogleFonts.mulish(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(color: Colors.white))),
                ),
                SizedBox(
                  height: 15,
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => HomePage()));
                    } else if (state is AuthError) {
                      String errorMessage = state.errorMessage;
                      showDialog(
                          context: context,
                          builder: (
                            _,
                          ) {
                            return AlertDialog(
                              title: const Text("Login Failed"),
                              content: Text("$errorMessage"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Ok"))
                              ],
                            );
                          });
                    }
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return ElevatedButton(
                        onPressed: () {
                          context.read<AuthCubit>().loginUser(
                              _emailController.text.trim(),
                              _passwordController.text);
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromRGBO(111, 111, 200, 1))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 114.0, right: 114, top: 10, bottom: 10),
                          child: Text("Login"),
                        ));
                  },
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignupPage()));
                    },
                    child: Text(
                      "Don't Have an Account , Signup Here",
                      style: GoogleFonts.mulish(color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
