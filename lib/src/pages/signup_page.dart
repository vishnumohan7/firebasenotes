import 'package:firebasenotes/src/bloc/auth_bloc/auth_cubit.dart';
import 'package:firebasenotes/src/models/user_model.dart';
import 'package:firebasenotes/src/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(31, 29, 43, 1),
        body: Form(
          child: Padding(
            padding: const EdgeInsets.only(left: 32.0,right: 32,bottom: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0.0, left: 30, right: 30),
                  child: Image.asset("assets/images/illus.png",height: 140,),
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),

                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",labelStyle: GoogleFonts.mulish(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                              color: Colors.white))
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),

                  controller: _passwordController,
                  decoration: InputDecoration(labelText: "Password",labelStyle: GoogleFonts.mulish(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                              color: Colors.white))),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),

                  controller: _nameController,
                  decoration: InputDecoration(labelText: "Name",labelStyle: GoogleFonts.mulish(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: BorderSide(
                              color: Colors.white))),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.white),

                  controller: _mobNoController,
                  decoration: InputDecoration(labelText: "Mobile",labelStyle: GoogleFonts.mulish(color: Colors.white),enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(7),
                      borderSide: BorderSide(
                          color: Colors.white))
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    } else if (state is AuthError) {
                      String errorMessage = state.errorMessage;
                      showDialog(
                          context: context,
                          builder: (
                            _,
                          ) {
                            return AlertDialog(
                              title: const Text("Signup Failed"),
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
                          UserModel user = UserModel(
                            email: _emailController.text,
                            name: _nameController.text,
                            password: _passwordController.text,
                            mobNo: _mobNoController.text,
                          );
                          context.read<AuthCubit>().createUser(user);
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromRGBO(111, 111, 200, 1))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 110,right: 110,top: 10,bottom: 10),
                          child: Text("Signup"),
                        ));
                  },
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginPage()));
                    },
                    child: Text(
                      "Already Have an Account , Login Here",
                      style: GoogleFonts.mulish(color: Colors.white),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
