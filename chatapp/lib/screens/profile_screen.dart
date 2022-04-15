import 'package:chatapp/app.dart';
import 'package:chatapp/screens/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import '../widgets/avatar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = context.currentUser;
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Avatar.large(url: user?.image),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(user?.name ?? 'No name'),
                ),
              ],
            ),
          ),
          const Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Phone number",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    Text(user?.extraData['phone'].toString()?? ''),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Username",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    Text(user?.extraData['email'].toString()?? ''),
                  ],
                ),
              ),
            ],
          ),
          const _SignOutButton(),
        ],
      ),
    );
  }
}

class _SignOutButton extends StatefulWidget {
  const _SignOutButton({
    Key? key,
  }) : super(key: key);

  @override
  __SignOutButtonState createState() => __SignOutButtonState();
}

class __SignOutButtonState extends State<_SignOutButton> {
  bool _loading = false;

  Future<void> _signOut() async {
    setState(() {
      _loading = true;
    });

    try {
      await StreamChatCore.of(context).client.disconnectUser();
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pop();
      Navigator.of(context).push(SignInScreen.route);
    } on Exception catch (e, st) {
      logger.e('Could not sign out', e, st);
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const CircularProgressIndicator()
        : TextButton(
            onPressed: _signOut,
            child: const Text('Sign out'),
          );
  }
}
