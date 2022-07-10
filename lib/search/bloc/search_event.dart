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

class ListScroll extends SearchEvent {
  const ListScroll();

  @override
  List<Object> get props => [];
}
