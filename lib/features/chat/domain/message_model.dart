import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String messageId;
  final String message;
  final Timestamp timestamp;
  final String type;
  final String? downloadUrl;
  final String? filename;
  final String clientId;
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
    required this.clientId,
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
      'clientId': clientId,
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
      clientId: map['clientId'] ?? '',
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
    return MessageModel(
      messageId: doc['messageId'] ?? '',
      message: doc['message'] ?? '',
      timestamp: doc['timestamp'] ?? Timestamp.now(),
      type: doc['type'] ?? 'text',
      downloadUrl: doc['downloadUrl'],
      filename: doc['filename'],
      clientId: doc['clientId'] ?? '',
      studioId: doc['studioId'] ?? '',
      replyMessage: doc['replyMessage'],
      replyMessageCategory: doc['replyMessageCategory'],
      replyMessageDownloadUrl: doc['replyMessageDownloadUrl'],
      replyMessageFileName: doc['replyMessageFileName'],
      replySenderId: doc['replySenderId'],
    );
  }
}
