import 'package:advancedflutter/main.dart';
import 'package:advancedflutter/views/loginView.dart';
import 'package:advancedflutter/views/registerView.dart';
import 'package:advancedflutter/views/verifyEmailVeiw.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as developer;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const Homepage(),
  ));
}

enum menuEnum {
  signin,
  logout;
}

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          actions: [
            PopupMenuButton<menuEnum>(
                onSelected: (value) async {
                  if(value == menuEnum.signin){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => registerView(title: "register")));
                  }
                  if (value == menuEnum.logout) {
                    FirebaseAuth.instance.signOut();
                    bool x = await _onBackPressed(context);
                    if (x) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const loginView(
                                    title: 'login',
                                  )),
                          (route) => false);
                    }
                  }
                },
                itemBuilder: (BuildContext context) =>
                    <PopupMenuEntry<menuEnum>>[
                      const PopupMenuItem<menuEnum>(
                        value: menuEnum.signin,
                        child: const Text('Sign in'),
                      ),
                      const PopupMenuItem(
                        value: menuEnum.logout,
                        child: Text("log out"),
                      )
                    ])
          ],
        ),
        body: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final user = FirebaseAuth.instance.currentUser;
              return loginView(title: 'Login');
            } else {
              return Text("Loading....");
            }
          },
        ));
  }

  Future<bool> _onBackPressed(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are you sure?"),
        content: Text("Do you want to exit and logout?"),
        actions: [
          FlatButton(
            child: Text("No"),
            onPressed: () => Navigator.pop(context, false),
          ),
          FlatButton(
            child: Text("Yes"),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    ).then((value) => value ?? false);
  }
  Widget signIn() {
    return registerView(title: 'Register');
  }
}
