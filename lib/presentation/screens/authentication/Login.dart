import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/auth_cubit/auth_cubit.dart';
import 'package:todo_app/presentation/common/AppButton.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String username;
  late String password;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Wrong Credentials'),
            backgroundColor: Colors.red,
          ));
        }

        if (state is LoggedIn) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Logged In'),
            backgroundColor: Colors.green,
          ));
          Navigator.pop(context);
          Navigator.pushNamed(context, '/home');
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 15, right: 15, top: 0, bottom: 8),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter Email Id',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onChanged: (value) {
                  this.username = value;
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 15.0),
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Enter Password',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
                onChanged: (value) {
                  this.password = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                top: 8.0,
                bottom: 5.0,
              ),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: AppButton(
                          buttonText: "Login",
                          onPressed: () {
                            // Validate will return true if the form is valid, or false if
                            // the form is invalid.
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<AuthCubit>(context)
                                  .login(this.username, this.password);
                            }
                          })),
                ],
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 14),
              ),
              onPressed: () => {Navigator.pushNamed(context, '/resetpassword')},
              child: const Text('FORGOT PASSWORD?'),
            ),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is LogingIn)
                  return CircularProgressIndicator();
                else
                  return Container();
              },
            )
          ],
        ),
      ),
    ));
  }
}
