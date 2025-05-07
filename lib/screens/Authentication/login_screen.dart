// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rev_rider/constants/text_field_decoration.dart';
import 'package:rev_rider/cubit/login_cubit.dart';
import 'package:rev_rider/cubit/login_state.dart';
import 'package:rev_rider/main.dart';
import 'package:rev_rider/screens/main_app/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const id = "LoginScreen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(uAuth),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccessful) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Login Successful"),
                ),
              );
              Navigator.pushNamed(context, HomeScreen.id);
            }
            if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Login Failed"),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is LoginLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 48.0,
                    ),
                    TextField(
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          email = value;
                        },
                        decoration:
                            TextFieldDecoration(hintText: "Enter Your Email")),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: TextFieldDecoration(
                            hintText: "Enter Your Password")),
                    SizedBox(
                      height: 24.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Material(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        elevation: 5.0,
                        child: MaterialButton(
                          //User Registration Function
                          onPressed: () async {
                            context
                                .read<LoginCubit>()
                                .login(email: email, password: password);

                            if (state is LoginSuccessful) {
                              print("Login Suc");
                            }
                            if (state is LoginFailure) {
                              print("Login failed");
                            }
                            // try {
                            //   User? user = await authService.signIn(email, password);
                            //   if (user != null) {
                            //     print('Signed in as: ${user.email}');

                            //     returnToPerviousScreen(context: context);
                            //   } else {
                            //     print('Sign-in failed.');
                            //   }
                            // } catch (e) {
                            //   print(e);
                            // }
                          },
                          minWidth: 200.0,
                          height: 42.0,
                          child: Text(
                            'Log In',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
