part of 'quick_order_auto_complete_bloc.dart';

abstract class QuickOrderAutoCompleteState {}

class QuickOrderInitialState extends QuickOrderAutoCompleteState {}

// class AutoCompleteInitialState extends QuickOrderAutoCompleteState {}

class QuickOrderAutoCompleteLoadingState extends QuickOrderAutoCompleteState {}

class QuickOrderAutoCompleteInitialState extends QuickOrderAutoCompleteState {}

class QuickOrderAutoCompleteLoadedState extends QuickOrderAutoCompleteState {

  final AutocompleteResult? result;

  QuickOrderAutoCompleteLoadedState({required this.result});

}

class QuickOrderAutoCompleteFailureState extends QuickOrderAutoCompleteState {

  final String error;

  QuickOrderAutoCompleteFailureState(this.error);

}
