class ChatMemberModel {
  final bool isAdmin;
  final bool receiveNotification;
  final String? lastMessageIdRead;

  ChatMemberModel({
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

  factory ChatMemberModel.fromMap(Map<String, dynamic> map) {
    return ChatMemberModel(
      isAdmin: map['isAdmin'] as bool,
      receiveNotification: map['receiveNotification'] as bool,
      lastMessageIdRead: map['lastMessageIdRead'] != null
          ? map['lastMessageIdRead'] as String
          : null,
    );
  }
}

class Member {
  final bool isAdmin;
  final bool receiveNotification;
  final String? lastMessageIdRead;
  final String id;

  Member({
    required this.isAdmin,
    required this.receiveNotification,
    this.lastMessageIdRead,
    required this.id,
  });
}
