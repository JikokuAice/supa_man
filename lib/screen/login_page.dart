import 'package:flutter/material.dart';
import 'package:supa_man/Bloc/bloc/auth_bloc_bloc.dart';
import 'package:supa_man/auth_repo/user_auth.dart';
import 'package:supa_man/screen/registration_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late AuthBlocBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = AuthBlocBloc(repository: UserAuth());
  }

  void _login() {
    // Implement your login logic here
    final email = _emailController.text;
    final password = _passwordController.text;
    print('Login with email: $email, password: $password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegistrationPage(
                              authBloc: _authBloc,
                            )));
              },
              child: Text('Don\'t have an account? Register'),
            ),
            GestureDetector(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 2,
                          color: Color.fromARGB(255, 230, 230, 230),
                          spreadRadius: 2,
                          blurStyle: BlurStyle.normal),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                        image: NetworkImage(
                            "https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png"))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
