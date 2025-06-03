import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String messageId;
  final String message;
  final Timestamp timestamp;
  final String type;
  final String? downloadUrl;
  final String? filename;
  final String senderId;
  final String studioId;
  final String? replyMessage;
  final String? replyMessageCategory;
  final String? replyMessageDownloadUrl;
  final String? replyMessageFileName;
  final String? replySenderId;

  MessageModel({
    required this.messageId,
    required this.message,
    required this.timestamp,
    required this.type,
    this.downloadUrl,
    required this.studioId,
    this.filename,
    required this.senderId,
    this.replyMessage,
    this.replyMessageCategory,
    this.replyMessageDownloadUrl,
    this.replyMessageFileName,
    this.replySenderId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messageId': messageId,
      'message': message,
      'timestamp': timestamp,
      'type': type,
      'downloadUrl': downloadUrl,
      'filename': filename,
      'senderId': senderId,
      'replyMessage': replyMessage,
      'replyMessageCategory': replyMessageCategory,
      'replyMessageDownloadUrl': replyMessageDownloadUrl,
      'replyMessageFileName': replyMessageFileName,
      'replySenderId': replySenderId,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      messageId: map['messageId'] ?? '',
      message: map['message'] ?? '',
      timestamp: map['timestamp'] ?? Timestamp.now(),
      type: map['type'] ?? 'text',
      downloadUrl: map['downloadUrl'],
      filename: map['filename'],
      senderId: map['senderId'] ?? '',
      studioId: map['studioId'] ?? '',
      replyMessage: map['replyMessage'],
      replyMessageCategory: map['replyMessageCategory'],
      replyMessageDownloadUrl: map['replyMessageDownloadUrl'],
      replyMessageFileName: map['replyMessageFileName'],
      replySenderId: map['replySenderId'],
    );
  }
  factory MessageModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) {
      throw StateError('Missing data for messageId: ${doc.id}');
    }

    return MessageModel(
      messageId: data['messageId'] ?? doc.id,
      message: data['message'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
      type: data['type'] ?? 'text',
      downloadUrl: data['downloadUrl'],
      filename: data['filename'],
      senderId: data['senderId'] ?? '',
      studioId: data['studioId'] ?? '',
      replyMessage: data['replyMessage'],
      replyMessageCategory: data['replyMessageCategory'],
      replyMessageDownloadUrl: data['replyMessageDownloadUrl'],
      replyMessageFileName: data['replyMessageFileName'],
      replySenderId: data['replySenderId'],
    );
  }
}
