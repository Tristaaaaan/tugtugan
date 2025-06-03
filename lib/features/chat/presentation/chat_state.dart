import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:tugtugan/features/chat/domain/chat_repository.dart';
import 'package:tugtugan/features/chat/domain/message_model.dart';

class RealTimeChatState extends ChangeNotifier {
  final RealTimeChatRepository _userRepo;
  late final ScrollController homeScrollController;

  List<MessageModel> users = [];
  bool isFetchingUsers = false;
  bool hasNextUser = true;
  bool hideFAB = false;
  final int limitTo = 20;

  StreamSubscription<QuerySnapshot<MessageModel>>? _messagesSubscription;
  bool _loading = false;

  RealTimeChatState(this._userRepo) {
    homeScrollController = ScrollController();
    homeScrollController.addListener(_listenToHomeScroll);
    _setupRealtimeListener();
    _loadInitialUsers();
  }

  void _setupRealtimeListener() {
    _messagesSubscription = _userRepo.messagesStream.listen((snapshot) {
      final newMessages = snapshot.docs.map((doc) => doc.data()).toList();

      // Merge with existing messages
      for (final message in newMessages) {
        final index = users.indexWhere((u) => u.messageId == message.messageId);
        if (index == -1) {
          users.add(message);
        } else {
          users[index] = message;
        }
      }

      // Sort by timestamp (newest first)
      users.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      notifyListeners();
    }, onError: (error) {
      debugPrint('Error in messages stream: $error');
    });
  }

  Future<void> _loadInitialUsers() async {
    if (_loading) return;
    _loading = true;
    isFetchingUsers = true;
    notifyListeners();

    await _userRepo.fetchUsers(limitTo);
    users = List.from(_userRepo.users);
    hasNextUser = _userRepo.hasNextUser;

    isFetchingUsers = false;
    _loading = false;
    notifyListeners();
  }

  Future<void> _loadNextBatchUsers() async {
    if (_loading || !hasNextUser) return;

    _loading = true;
    isFetchingUsers = true;
    notifyListeners();

    await _userRepo.fetchUsers(limitTo);
    users = List.from(_userRepo.users);
    hasNextUser = _userRepo.hasNextUser;

    isFetchingUsers = false;
    _loading = false;
    notifyListeners();
  }

  void _listenToHomeScroll() {
    final position = homeScrollController.position;

    if (position.maxScrollExtent < 200) return;

    if (position.pixels >= position.maxScrollExtent - 150 && hasNextUser) {
      _loadNextBatchUsers();
    }

    _hideFAB();
  }

  void _hideFAB() {
    final direction = homeScrollController.position.userScrollDirection;

    if (direction == ScrollDirection.forward && hideFAB) {
      hideFAB = false;
      notifyListeners();
    } else if (direction == ScrollDirection.reverse && !hideFAB) {
      hideFAB = true;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _messagesSubscription?.cancel();
    homeScrollController.dispose();
    super.dispose();
  }
}
