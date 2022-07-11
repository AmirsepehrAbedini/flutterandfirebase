import 'package:advancedflutter/firebase_options.dart';
import 'package:advancedflutter/main.dart';
import 'package:advancedflutter/views/loginView.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
class registerView extends StatefulWidget {
  const registerView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<registerView> createState() => _registerViewState();
}

class _registerViewState extends State<registerView> {
  TextEditingController emailContoroller = TextEditingController();
  TextEditingController passwordContoroller = TextEditingController();

  @override
  void initState() {
    emailContoroller = TextEditingController();
    passwordContoroller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailContoroller.dispose();
    passwordContoroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 10),
              child: TextField(
                controller: emailContoroller,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 10),
              child: TextField(
                controller: passwordContoroller,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            TextButton(
                onPressed: () async {
                  final password = passwordContoroller.text;
                  final email = emailContoroller.text;
                  try {
                    final userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                        email: email, password: password);
                  } catch (error) {
                    print(error);
                  }
                },
                child: Text('register')),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );

  }
}