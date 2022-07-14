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

class PageChanged extends SearchEvent {
  const PageChanged({required this.page});

  final int page;

  @override
  List<Object> get props => [page];
}

class Refresh extends SearchEvent {
  const Refresh();

  @override
  List<Object> get props => [];
}
