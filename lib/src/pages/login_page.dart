import 'package:firebasenotes/src/bloc/auth_bloc/auth_cubit.dart';
import 'package:firebasenotes/src/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Form(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: "Email"),
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
                        child: Text("Login"));
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
