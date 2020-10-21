import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:pract_dos/models/todo_reminder.dart';

import '../../models/todo_reminder.dart';
import '../../models/todo_reminder.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  //  inicializar la box
  Box _remainderBox = Hive.box('Reminder');
  HomeBloc() : super(HomeInitialState());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is OnLoadRemindersEvent) {
      try {
        List<TodoRemainder> _existingReminders = _loadReminders();
        yield LoadedRemindersState(todosList: _existingReminders);
      } on DatabaseDoesNotExist catch (_) {
        yield NoRemindersState();
      } on EmptyDatabase catch (_) {
        yield NoRemindersState();
      }
    }
    if (event is OnAddElementEvent) {
      _saveTodoReminder(event.todoReminder);
      yield NewReminderState(todo: event.todoReminder);
    }
    if (event is OnReminderAddedEvent) {
      yield AwaitingEventsState();
    }
    if (event is OnRemoveElementEvent) {
      _removeTodoReminder(event.removedAtIndex);
    }
  }

  List<TodoRemainder> _loadReminders() {
    if (_remainderBox.isNotEmpty)
      return List<TodoRemainder>.from(_remainderBox.get('Remainders'));
    throw EmptyDatabase();
  }

  void _saveTodoReminder(TodoRemainder todoReminder) {
    var _remainders = List();
    if (_remainderBox.isNotEmpty) _remainders = _remainderBox.get('Remainders');
    _remainders.add(todoReminder);
    _remainderBox.put('Remainders', _remainders);
  }

  void _removeTodoReminder(int removedAtIndex) {
    var _remainders = List();
    _remainders = _remainderBox.get('Remainders');
    if (_remainderBox.isNotEmpty) {
      _remainders.removeAt(removedAtIndex);
      _remainderBox.put('Remainders', _remainders);
    }
  }
}

class DatabaseDoesNotExist implements Exception {}

class EmptyDatabase implements Exception {}
