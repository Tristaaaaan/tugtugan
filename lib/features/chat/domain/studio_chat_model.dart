import 'package:cloud_firestore/cloud_firestore.dart';

class StudioChatModel {
  final String? studioChatId;
  final String clientId;
  final String studioId;
  final String lastMessage;
  final String lastMessageSenderId;
  final Timestamp lastMessageTimeSent;
  final String lastMessageType;
  final String? lastMessageId;
  final Map<String, ChatMembers>? members;

  StudioChatModel({
    this.studioChatId,
    required this.clientId,
    required this.studioId,
    required this.lastMessage,
    required this.lastMessageSenderId,
    required this.lastMessageTimeSent,
    required this.lastMessageType,
    this.lastMessageId,
    this.members,
  });
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'studioChatId': studioChatId,
      'clientId': clientId,
      'studioId': studioId,
      'lastMessage': lastMessage,
      'lastMessageSenderId': lastMessageSenderId,
      'lastMessageTimeSent': lastMessageTimeSent,
      'lastMessageType': lastMessageType,
      'lastMessageId': lastMessageId,
      'members': members?.map((key, value) => MapEntry(key, value.toMap())),
    };
  }
}

class ChatMembers {
  final bool isAdmin;
  final bool receiveNotification;
  final String? lastMessageIdRead;

  ChatMembers({
    required this.isAdmin,
    required this.receiveNotification,
    this.lastMessageIdRead,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isAdmin': isAdmin,
      'receiveNotification': receiveNotification,
      'lastMessageIdRead': lastMessageIdRead,
    };
  }

  factory ChatMembers.fromMap(Map<String, dynamic> map) {
    return ChatMembers(
      isAdmin: map['isAdmin'] as bool,
      receiveNotification: map['receiveNotification'] as bool,
      lastMessageIdRead: map['lastMessageIdRead'] != null
          ? map['lastMessageIdRead'] as String
          : null,
    );
  }
}

class MembersMap {
  Map<String, ChatMembers>? members;

  MembersMap({this.members});

  Map<String, dynamic> toMap() {
    return {
      'members': members!.map((key, value) => MapEntry(key, value.toMap())),
    };
  }
}
