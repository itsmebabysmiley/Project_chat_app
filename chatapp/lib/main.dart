import 'package:chatapp/app.dart';
import 'package:chatapp/screens/sign_in_screen.dart';
import 'package:chatapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  
  final client = StreamChatClient(streamKey); // Stream core
  WidgetsFlutterBinding.ensureInitialized(); // Firebase configure.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MyApp(
      streamChatClient: client,
      appTheme: AppTheme(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.streamChatClient,
    required this.appTheme,
  }) : super(key: key);
  final StreamChatClient streamChatClient;
  final AppTheme appTheme;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme.light,
      darkTheme: appTheme.dark,
      themeMode: ThemeMode.light,
      title: 'ChatKu',
      builder: (context, child) {
        return StreamChatCore(
          client: streamChatClient,
          child: ChannelsBloc(
            child: UsersBloc(child: child!),
          ),
        );
      },
      home: const SignInScreen(),
    );
  }
}
