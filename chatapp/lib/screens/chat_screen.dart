import 'package:chatapp/models/message.dart';
import 'package:chatapp/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/avatar.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key, required this.messageData}) : super(key: key);

  final MessageData messageData;

  static Route route(MessageData data) => MaterialPageRoute(
        builder: (context) => ChatScreen(
          messageData: data,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor: Colors.white,
        elevation: 0.25,
        centerTitle: true,
        title: _CustomAppBarTitle(
          title: messageData.senderName,
          subTitle: "JOSH W. BUSH",
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(child: Icon(Icons.more_horiz_outlined)),
            ),
          ),
        ],
      ),
      body: Column(children: [
        Expanded(
          child: _DemoMessageList(
            messageData: messageData,
          ),
        ),
        _ActionBar(),
      ]),
    );
  }
}

class _CustomAppBarTitle extends StatelessWidget {
  const _CustomAppBarTitle(
      {Key? key, required this.title, required this.subTitle})
      : super(key: key);

  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
            const SizedBox(height: 2),
            Text(
              subTitle,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ]),
    );
  }
}

class _DateLable extends StatelessWidget {
  const _DateLable({
    Key? key,
    required this.lable,
  }) : super(key: key);

  final String lable;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
            child: Text(
              lable,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.textFaded,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OurMessages extends StatelessWidget {
  const _OurMessages(
      {Key? key,
      required this.message,
      required this.messageDate,
      required this.senderName,
      required this.picUrl})
      : super(key: key);

  final String message;
  final String messageDate;
  final String senderName;
  final String picUrl;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Text(senderName),
            //     Padding(
            //         padding: const EdgeInsets.all(10.0),
            //         child: Avatar.medium(url: picUrl),
            //     ),
            //   ],
            // ),
            Container(
              width: size.width * 0.75,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(message,
                    style: const TextStyle(
                      color: AppColors.textDark,
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 10.0),
              child: Text(
                messageDate,
                style: const TextStyle(
                  color: AppColors.textDark,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({
    Key? key,
    required this.message,
    required this.messageDate,
  }) : super(key: key);

  final String message;
  final String messageDate;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width * 0.75,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
                child: Text(message),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                messageDate,
                style: const TextStyle(
                  color: AppColors.textFaded,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 2,
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(
                CupertinoIcons.camera_fill,
              ),
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: TextField(
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Type something...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: (() {
              print("tap");
            }),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 12,
                right: 24.0,
              ),
              child: Container(
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                  child: Text(
                    "Send",
                    style: TextStyle(color: AppColors.secondary),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DemoMessageList extends StatelessWidget {
  const _DemoMessageList({Key? key, required this.messageData})
      : super(key: key);
  final MessageData messageData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        children: [
          _DateLable(lable: 'Yesterday'),
          _Message(
            message: 'You know how it goes...',
            messageDate: '12:02 PM',
          ),
          _OurMessages(
            message: 'Hi, Lucy! How\'s your day going? Can we hang out later?',
            messageDate: '12:01 PM',
            picUrl: messageData.profilePicture,
            senderName: messageData.senderName,
          ),
          _Message(
            message: 'Would be awesome!',
            messageDate: '12:03 PM',
          ),
          _OurMessages(
            message: 'Do you want Starbucks?',
            messageDate: '12:02 PM',
            picUrl: messageData.profilePicture,
            senderName: messageData.senderName,
          ),
          _OurMessages(
            message: 'Coming up!',
            messageDate: '12:03 PM',
            picUrl: messageData.profilePicture,
            senderName: messageData.senderName,
          ),
          _Message(
            message: 'YAY!!!',
            messageDate: '12:03 PM',
          ),
        ],
      ),
    );
  }
}
