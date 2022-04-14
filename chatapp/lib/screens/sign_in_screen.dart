import 'package:chatapp/screens/home_screen.dart';
import 'package:chatapp/screens/sign_up_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

class SignInScreen extends StatefulWidget {
  static Route get route => MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      );
  const SignInScreen({Key? key}) : super(key: key);
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoggingIn = false;
  final fb.FirebaseAuth _auth = fb.FirebaseAuth.instance;
  Future _login() async {
    setState(() {
      isLoggingIn = true;
    });

    try {
      await _auth.signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
      final client = StreamChatCore.of(context).client;

      await FirebaseFirestore.instance.collection('users').get().then(
            (querySnapshot) async => {
              for(var doc in querySnapshot.docs){

                if (doc['email'].toString() == _emailController.text) {
                    await client.connectUser(
                      User(
                        id: doc.id.toString(),
                        extraData: {
                          'name': doc['name'].toString(),
                          'email': doc['email'].toString(),
                          'image': doc['imageUrl'].toString(),
                          'phone': doc['phone'].toString()
                        },
                      ),
                      client.devToken(doc.id.toString()).rawValue,
                    )
                  }
              }
            },
          );
      // successful login with firebase and login with stream chat. push to home screen.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } on fb.FirebaseAuthException catch (e) {
      var message = '';
      switch (e.code) {
        case 'invalid-email':
          message = 'Invalid Email';
          break;
        case 'user-disabled':
          message = 'The user you tried to log into is disable';
          break;
        case 'user-not-found':
          message = 'The user you tried to log into was not found';
          break;
        case 'wrong-password':
          message = 'Incorrect password';
          break;
      }
      if (_emailController.text == '' && _passwordController.text == '') {
        message = 'please enter email and password';
      }
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Log in failed'),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK')),
              ],
            );
          });
    } finally {
      setState(() {
        isLoggingIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ChatKu',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                )),
            const SizedBox(height: 5),
            Text('Log In',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType
                    .emailAddress, // the keyboard will has .com, @ for easily typing
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0),
              child: TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true, //hiding the password
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28, left: 50.0, right: 50.0),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                    onPressed: () {
                      _login();
                    },
                    child:
                        const Text('Log in', style: TextStyle(fontSize: 20))),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Don't have an account? ",
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(SignUpScreen.route);
                  },
                  child: const Text("Sign up",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      )),
                )
              ],
            ),
            if (isLoggingIn) ...[
              const SizedBox(height: 16),
              const Center(child: CircularProgressIndicator()),
            ]
          ],
        ),
      ),
    );
  }
}
