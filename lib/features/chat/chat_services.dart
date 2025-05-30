import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tugtugan/core/appmodels/conversation_model.dart';
import 'package:tugtugan/core/appmodels/studio_chat_model.dart';

class ChatServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // create a new conversation
  Future<void> addInbox(StudioChatModel studioChatModel) async {
    await _firestore
        .collection('studios')
        .doc(studioChatModel.studioId)
        .collection('inbox')
        .doc("${studioChatModel.studioId}${studioChatModel.clientId}")
        .set(studioChatModel.toMap());
  }

  // send a message to the studio's inbox
  Future<void> addMessage(
    MessageModel messageModel,
  ) async {
    await _firestore
        .collection('studios')
        .doc(messageModel.studioId)
        .collection('inbox')
        .doc("${messageModel.studioId}${messageModel.clientId}")
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      // Studio Model to send message
      final StudioChatModel sendMessage = StudioChatModel(
        clientId: messageModel.clientId,
        studioId: messageModel.studioId,
        lastMessage: messageModel.message,
        lastMessageSenderId: messageModel.clientId,
        lastMessageTimeSent: Timestamp.now(),
        lastMessageType: "text",
        lastMessageId: value.id,
        studioChatId: "${messageModel.studioId}${messageModel.clientId}",
        members: {
          messageModel.studioId: ChatMembers(
            isAdmin: false,
            receiveNotification: true,
          ),
          messageModel.clientId: ChatMembers(
            isAdmin: true,
            receiveNotification: true,
            lastMessageIdRead: value.id,
          ),
        },
      );

      addInbox(sendMessage);
    });
  }
}

// // send chat message
// Future<bool> sendMessage(
//   String groupChatid,
//   String message,
//   String type,
//   String downloadUrl,
//   String institutionId,
//   String groupChatTitle,
//   String category,
//   String filename,
//   bool isGroup,
//   String replyMessage,
//   String senderId,
//   String replyMessageCategory,
//   String replyMessageDownloadUrl,
//   String replyMessageFileName,
// ) async {
//   // current user Info
//   final userInfo =
//       await _users.getUserInfo(_firebaseAuth.currentUser!.uid, institutionId);

//   final userInfodata = userInfo.data();

//   final userName = userInfodata!['name'];

//   // get current user info
//   final String currentUserId = _firebaseAuth.currentUser!.uid;
//   final String curreUserEmail = userName;

//   String replyToUserName = '';
//   // replyToInfo
//   if (senderId != '') {
//     final replyToInfo = await _users.getUserInfo(senderId, institutionId);

//     final replyToUserInfodata = replyToInfo.data();

//     replyToUserName = replyToUserInfodata!['name'];

//     print("Reply to Username: $replyToUserName");
//   }

//   final Timestamp timestamp = Timestamp.now();

//   // get all members where Notification = true
//   final membersIdNotif = await membersWithNotificationOn(
//     groupChatid,
//     institutionId,
//     isGroup,
//   );

//   // get all their FCM token
//   final listfcmtoken = [];

//   for (String memberId in membersIdNotif) {
//     // Skip adding the token if it belongs to the current user
//     if (memberId == _firebaseAuth.currentUser!.uid) {
//       continue;
//     }

//     // Get user info for the member
//     final userInfo = await _users.getUserInfo(memberId, institutionId);
//     // Assuming user info contains fcmtoken
//     final userfcmToken = userInfo['fcmtoken'];
//     // Add the FCM token to the list
//     listfcmtoken.add(userfcmToken);
//   }

//   final List<String> nameParts = userName.split(' ');
//   final String firstName = nameParts[0];
//   final String format = firstName.substring(0, 1).toUpperCase() +
//       firstName.substring(1).toLowerCase();

//   // create a new message
//   MessageModel newMessage = MessageModel(
//     senderId: currentUserId,
//     groupChatId: groupChatid,
//     message: message,
//     timestamp: timestamp,
//     type: type,
//     downloadUrl: downloadUrl,
//     category: category,
//     filename: filename,
//     senderName: curreUserEmail,
//     replyMessage: replyMessage,
//     replyMessageCategory: replyMessageCategory,
//     replyMessageDownloadUrl: replyMessageDownloadUrl,
//     replyMessageFileName: replyMessageFileName,
//     replySenderName: replyToUserName,
//     replySenderId: senderId,
//   );

//   if (isGroup) {
//     // add new message to database
//     DocumentReference newMessageRef = await _firestore
//         .collection("institution")
//         .doc(institutionId)
//         .collection('study_groups')
//         .doc(groupChatid)
//         .collection("messages")
//         .add(
//           newMessage.toMap(),
//         );

//     String messageId = newMessageRef.id;
//     // add GroupChat LastMessage, LastMessageSender, and LastMessageTimeSent
//     _firestore
//         .collection("institution")
//         .doc(institutionId)
//         .collection("study_groups")
//         .doc(groupChatid)
//         .update(
//       {
//         "lastMessage": message,
//         "lastMessageSender": curreUserEmail,
//         "lastMessageTimeSent": timestamp,
//         "lastMessageType": type,
//         "lastMessageId": messageId,
//       },
//     );

//     await updateUserLastMessageIdRead(
//       groupChatid,
//       institutionId,
//       messageId,
//       _firebaseAuth.currentUser!.uid,
//       true,
//     );

//     for (String fcmtoken in listfcmtoken) {
//       //send notification
//       _firebaseMessage.sendPushMessage(
//         recipientToken: fcmtoken,
//         title: groupChatTitle,
//         body: "$format: $message",
//         route: 'groupchats',
//         imageUrl: downloadUrl,
//       );
//     }

//     return true;
//   } else {
//     DocumentReference newMessageRef = await _firestore
//         .collection("institution")
//         .doc(institutionId)
//         .collection('direct_messages')
//         .doc(groupChatid)
//         .collection("messages")
//         .add(
//           newMessage.toMap(),
//         );

//     String messageId = newMessageRef.id;
//     // add GroupChat LastMessage, LastMessageSender, and LastMessageTimeSent
//     _firestore
//         .collection("institution")
//         .doc(institutionId)
//         .collection("direct_messages")
//         .doc(groupChatid)
//         .update(
//       {
//         "lastMessage": message,
//         "lastMessageSender": curreUserEmail,
//         "lastMessageTimeSent": timestamp,
//         "lastMessageType": type,
//         "lastMessageId": messageId,
//       },
//     );

//     await updateUserLastMessageIdRead(
//       groupChatid,
//       institutionId,
//       messageId,
//       _firebaseAuth.currentUser!.uid,
//       false,
//     );

//     for (String fcmtoken in listfcmtoken) {
//       //send notification
//       _firebaseMessage.sendPushMessage(
//         recipientToken: fcmtoken,
//         title: groupChatTitle,
//         body: message,
//         route: 'appointment',
//         imageUrl: downloadUrl,
//       );
//     }

//     return true;
//   }
// }
