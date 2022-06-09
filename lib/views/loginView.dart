import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class loginView extends StatefulWidget {
  const loginView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<loginView> createState() => _loginViewState();
}

class _loginViewState extends State<loginView> {

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10),
                    child: TextField(
                      controller: emailContoroller,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
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
                    try{    await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                            email: email, password: password);
                           print('sign in with email and password');
                        }
                    on FirebaseAuthException catch (e) {
                      if(e.code == 'user-not-found'){
                        print('user not found');
                      }else if(e.code == 'wrong-password'){
                        print('wrong password');
                      }
    }},
                      child: Text('Login')),
                ],
              ), // This trailing comma makes auto-formatting nicer for build methods.
            );
          }
        },
      ),
    );
  }
}
