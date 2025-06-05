import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tugtugan/features/chat/domain/studio_chat_model.dart';

import '../domain/realtime_inbox_repository.dart';

class RealTimeInboxState extends ChangeNotifier {
  final RealTimeInboxRepository _inboxRepo;
  late final ScrollController scrollController;

  List<StudioChatModel> _inbox = [];
  bool _isLoading = false;
  bool _hasMoreInbox = true;
  bool _hideFAB = false;
  final int _limit = 20;

  StreamSubscription<List<StudioChatModel>>? _inboxSubscription;

  // Getters for private fields
  List<StudioChatModel> get inbox => List.from(_inbox);
  bool get isLoading => _isLoading;
  bool get hasMoreInbox => _hasMoreInbox;
  bool get hideFAB => _hideFAB;

  RealTimeInboxState(this._inboxRepo) {
    scrollController = ScrollController();
    scrollController.addListener(_handleScroll);
    _setupRealtimeListener();
    _loadInitialInbox();
  }

  void _setupRealtimeListener() {
    _inboxSubscription = _inboxRepo.inboxStream.listen((chats) {
      _inbox = chats; // Already sorted by lastMessageTimeSent from repository
      notifyListeners();
    }, onError: (error) {
      debugPrint('Error in inbox stream: $error');
    });
  }

  Future<void> _loadInitialInbox() async {
    if (_isLoading) return;
    _isLoading = true;
    notifyListeners();

    await _inboxRepo.loadMoreInbox(limit: _limit);
    _hasMoreInbox = _inboxRepo.hasMoreInbox;

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _loadNextInboxBatch() async {
    if (_isLoading || !_hasMoreInbox) return;

    _isLoading = true;
    notifyListeners();

    await _inboxRepo.loadMoreInbox(limit: _limit);
    _hasMoreInbox = _inboxRepo.hasMoreInbox;

    _isLoading = false;
    notifyListeners();
  }

  void _handleScroll() {
    final position = scrollController.position;

    // Load more when scrolled near bottom
    if (position.pixels >= position.maxScrollExtent - 200 && _hasMoreInbox) {
      _loadNextInboxBatch();
    }

    // Handle FAB visibility
    _updateFABVisibility();
  }

  void _updateFABVisibility() {
    final direction = scrollController.position.userScrollDirection;
    final newHideState = direction == ScrollDirection.reverse;

    if (newHideState != _hideFAB) {
      _hideFAB = newHideState;
      notifyListeners();
    }
  }

  void refreshInbox() {
    _inboxRepo.reset();
    _inbox.clear();
    _hasMoreInbox = true;
    _loadInitialInbox();
  }

  @override
  void dispose() {
    _inboxSubscription?.cancel();
    scrollController.dispose();
    super.dispose();
  }
}
