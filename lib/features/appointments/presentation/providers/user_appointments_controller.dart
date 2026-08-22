import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tugtugan/features/appointments/domain/repository/user_appoinments_repo.dart';
import 'package:tugtugan/features/appointments/presentation/providers/user_appointments_states.dart';
import 'package:tugtugan/features/book_appointment/domain/entities/appointment_entity.dart';

class UserAppointmentsController extends StateNotifier<UserAppointmentsStates> {
  final UserAppointmentsRepository _userAppointmentsRepository;
  int? _lastUpdatedAt;
  bool _hasMore = true;
  bool _isLoading = false;
  final List<AppointmentEntity> _appointments = [];
  final int _pageSize = 10;

  UserAppointmentsController(this._userAppointmentsRepository)
      : super(const UserAppointmentsStates.initial()) {
    fetchInitial();
  }

  Future<void> fetchInitial() async {
    if (_isLoading) return;
    _lastUpdatedAt = null;
    _hasMore = true;
    _appointments.clear();
    state = const UserAppointmentsStates.loading();
    await _load();
  }

  Future<void> _load() async {
    developer.log('_load triggered');
    _isLoading = true;
    try {
      final wasFirstLoad = _lastUpdatedAt == null;
      developer.log('wasFirstLoad: $wasFirstLoad');

      // ✅ Removed the ! null assertion - pass nullable directly
      final tasks =
          await _userAppointmentsRepository.readAppointments(_lastUpdatedAt);
      developer.log('tasks: ${tasks.length}');

      _hasMore = tasks.length == _pageSize;

      if (tasks.isNotEmpty) {
        _lastUpdatedAt = tasks.last.updatedAt;
      }

      if (wasFirstLoad) {
        _appointments.clear();
        _appointments.addAll(tasks);
      } else {
        _appointments.insertAll(0, tasks);
      }

      state = _appointments.isEmpty
          ? const UserAppointmentsStates.empty()
          : UserAppointmentsStates.loaded(
              List.unmodifiable(_appointments), _hasMore);
    } catch (e, stackTrace) {
      developer.log('Error in _load: $e');
      developer.log('$stackTrace');
      state = UserAppointmentsStates.error(e.toString());
    } finally {
      _isLoading = false;
    }
  }

  Future<void> loadMore() async {
    if (!_hasMore || _isLoading) {
      developer.log(
        'loadMore skipped — hasMore: $_hasMore | isLoading: $_isLoading',
      );
      return;
    }
    developer.log('loadMore triggered');
    await _load();
  }

  Future<void> refreshAppoinments() async {
    if (_isLoading) return;
    _isLoading = true;

    try {
      final currentCount = _appointments.length;
      final reloadCount = currentCount < _pageSize ? _pageSize : currentCount;

      final messages = await _userAppointmentsRepository.readAppointments(
        null,
        limit: reloadCount,
      );

      _appointments.clear();
      _appointments.addAll(messages);

      if (messages.isNotEmpty) {
        _lastUpdatedAt = messages.last.updatedAt;
      } else {
        _lastUpdatedAt = null;
      }

      _hasMore = messages.length == reloadCount;

      state = _appointments.isEmpty
          ? const UserAppointmentsStates.empty()
          : UserAppointmentsStates.loaded(
              List.unmodifiable(_appointments), _hasMore);
    } catch (e) {
      state = UserAppointmentsStates.error(e.toString());
    } finally {
      _isLoading = false;
    }
  }
}
