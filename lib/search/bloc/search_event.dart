part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class QueryChanged extends SearchEvent {
  const QueryChanged({required this.query});

  final String query;

  @override
  List<Object> get props => [query];
}

class ScrollDown extends SearchEvent {
  const ScrollDown();

  @override
  List<Object> get props => [];
}

class Refresh extends SearchEvent {
  const Refresh();

  @override
  List<Object> get props => [];
}

class DeleteQuery extends SearchEvent{
  const DeleteQuery();

  @override
  List<Object> get props => [];
}
