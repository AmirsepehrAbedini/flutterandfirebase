
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class verifyEmail extends StatefulWidget {
  const verifyEmail({Key? key}) : super(key: key);

  @override
  State<verifyEmail> createState() => _verifyEmailState();
}

class _verifyEmailState extends State<verifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Email'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You must verify your email address before you can log in.',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            RaisedButton(
              child: Text('Send verification email'),
              onPressed: () {
                FirebaseAuth.instance.currentUser?.sendEmailVerification();
              },
            ),
        ],
    ),
    ),
    );
  }
}
