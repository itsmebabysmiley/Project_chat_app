import 'package:chatapp/screens/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../helper.dart';

class SignUpScreen extends StatefulWidget {
  static Route get route => MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      );

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isSignUp = false;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser(String email, String name, String phone) {
      // Call the user's CollectionReference to add a new user
      return users
          .add({
            'email': email,
            'name': name,
            'imageUrl': Helpers.randomPictureUrl(),
            'phone': phone,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    _signUpWithEmailPassword() async {
      setState(() {
        isSignUp = true;
      });
      try {
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        // also add new user to users collection.
        await addUser(
          _emailController.text,
          _nameController.text,
          _phoneController.text,
        );
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Successfully!'),
            content: const Text("Sign up complete."),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok'))
            ],
          ),
        );
        Navigator.of(context).pop();
        Navigator.of(context).push(SignInScreen.route);
      } on FirebaseAuthException catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Sign up failed'),
            content: Text(e.message.toString()),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok'))
            ],
          ),
        );
      } on Exception catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error Occured'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok'))
            ],
          ),
        );
      } finally {
        setState(() {
          isSignUp = false;
        });
      }
    }

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
            Text('Sign Up',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                )),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0),
              child: TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType
                    .text, // the keyboard will has .com, @ for easily typing
              ),
            ),
            const SizedBox(height: 18),
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
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.only(left: 50.0, right: 50.0),
              child: TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number, //hiding the password
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28, left: 50.0, right: 50.0),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                    onPressed: () {
                      _signUpWithEmailPassword();
                    },
                    child:
                        const Text('Sign Up', style: TextStyle(fontSize: 20))),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Already have an account? ",
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(SignInScreen.route);
                  },
                  child: const Text("Sign in",
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      )),
                )
              ],
            ),
            if (isSignUp) ...[
              const SizedBox(height: 16),
              const Center(child: CircularProgressIndicator()),
            ]
          ],
        ),
      ),
    );
  }
}
