import 'package:firebasenotes/src/bloc/auth_bloc/auth_cubit.dart';
import 'package:firebasenotes/src/models/user_model.dart';
import 'package:firebasenotes/src/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        appBar: AppBar(
          title: Text("Signup"),
        ),
        body: Form(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: "Password"),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: "Name"),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _mobNoController,
                  decoration: InputDecoration(labelText: "Mobile"),
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
                        child: Text("Signup"));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
