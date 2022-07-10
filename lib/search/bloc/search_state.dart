part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  
  @override
  List<Object> get props => [];
}

class SearchStateEmpty extends SearchState{}

class SearchStateLoading extends SearchState{}

class SearchStateFailure extends SearchState{
  const SearchStateFailure(this.error);

  final String error;
  
  @override
  List<Object> get props => [error];
}

class SearchStateSuccess extends SearchState{
  const SearchStateSuccess({
    this.recipes = const [],
  });

  final List<Recipe> recipes;

  @override
  List<Object> get props => [recipes];
}
