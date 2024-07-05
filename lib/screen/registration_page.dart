import 'package:flutter/material.dart';
import 'package:supa_man/Bloc/bloc/auth_bloc_bloc.dart';
import 'package:supa_man/model/user_model/Users.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegistrationPage extends StatefulWidget {
  final AuthBlocBloc authBloc;
  RegistrationPage({required this.authBloc});
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formkeys = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? isValidEmail(String? email) {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final isvalid = emailRegExp.hasMatch(email ?? '');
    if (!isvalid) {
      return "please use proper email";
    }
    return null;
  }

  String? isValidPassword(String? confirm) {
    if (_passwordController.text != confirm) {
      return "confirm password didnt match";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formkeys,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (val) {
                  if (val == null || val == '') {
                    return "name missing";
                  }
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: isValidEmail,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              TextFormField(
                controller: _confirmPasswordController,
                validator: isValidPassword,
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {},
                  child: const SizedBox(
                    width: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [Text("Pick image 📸")],
                    ),
                  )),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formkeys.currentState!.validate()) {
                    final User = Users(
                        name: _nameController.text,
                        email: _emailController.text,
                        Password: _passwordController.text,
                        confirm: _confirmPasswordController.text);
                    widget.authBloc.add(SignIn(users: User));
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
