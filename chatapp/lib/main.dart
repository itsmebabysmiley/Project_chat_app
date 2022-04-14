import 'package:chatapp/app.dart';
import 'package:chatapp/screens/home_screen.dart';
import 'package:chatapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

import 'screens/select_user_screen.dart';

void main() {
  final client = StreamChatClient(streamKey);

  runApp(
    MyApp(
      streamChatClient: client,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.streamChatClient,
  }) : super(key: key);
  final StreamChatClient streamChatClient;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
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
      home: SelectUserScreen(),
    );
  }
}
