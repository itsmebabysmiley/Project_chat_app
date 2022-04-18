import 'dart:math';

import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

 // Ref: https://github.com/HayesGordon/chatter/tree/tutorial-002-stream-chat-flutter-core-complete
abstract class Helpers {
  static final random = Random();

  //random picture profile.
  static String randomPictureUrl() {
    final randomInt = random.nextInt(1000);
    return 'https://picsum.photos/seed/$randomInt/300/300';
  }
  //random date for mock up.
  static DateTime randomDate() {
    final random = Random();
    final currentDate = DateTime.now();
    return currentDate.subtract(Duration(seconds: random.nextInt(200000)));
  }
  // because stream chat doesn't keep channels for individual users, we need to create function that 
  // get only channels that belongs to specific user.
  // this function will return channels that belong to current user.
 
  static String getChannelName(Channel channel, User currentUser) {
    if (channel.name != null) { // return channel name which is chatter.
      return channel.name!;
    } 
    else if (channel.state?.members.isNotEmpty ?? false) { // return list of channels. WE DONT USED THIS ONE BECAUSE WE CAN CHAT ONLY P2P.
      final otherMembers = channel.state?.members
          .where(
            (element) => element.userId != currentUser.id,
          )
          .toList();

      if (otherMembers?.length == 1) {
        return otherMembers!.first.user?.name ?? 'No name';
      } else {
        return 'Multiple users';
      }
    } else {
      return 'No Channel Name';
    }
  }
  // not used
  static String? getChannelImage(Channel channel, User currentUser) {
    if (channel.image != null) {
      return channel.image!;
    } else if (channel.state?.members.isNotEmpty ?? false) {
      final otherMembers = channel.state?.members // group channel
          .where(
            (element) => element.userId != currentUser.id,
          )
          .toList();

      if (otherMembers?.length == 1) {
        return otherMembers!.first.user?.image;
      }
    } else {
      return null;
    }
    return null;
  }
  
}