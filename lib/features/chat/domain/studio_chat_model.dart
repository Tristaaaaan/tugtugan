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

  factory StudioChatModel.fromMap(Map<String, dynamic> map) {
    return StudioChatModel(
      studioChatId: map['studioChatId'] as String?,
      clientId: map['clientId'] as String,
      studioId: map['studioId'] as String,
      lastMessage: map['lastMessage'] as String,
      lastMessageSenderId: map['lastMessageSenderId'] as String,
      lastMessageTimeSent: map['lastMessageTimeSent'] as Timestamp,
      lastMessageType: map['lastMessageType'] as String,
      lastMessageId: map['lastMessageId'] as String?,
      members: (map['members'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(key, ChatMembers.fromMap(value)),
      ),
    );
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
