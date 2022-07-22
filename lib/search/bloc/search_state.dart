part of 'search_bloc.dart';

enum SearchStatus {empty, loading, success, failure}

class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.empty,
    this.query = '',
    this.page = 1,
    this.recipes = const [],
    this.message = '',
    this.hasReachMax = false,
    this.isCaching = false,
  });
  
  final SearchStatus status;
  final String query;
  final String message;
  final int page;
  final bool hasReachMax;
  final bool isCaching;
  final List<Recipe> recipes;

  SearchState copyWith({
    SearchStatus? status,
    String? query,
    String? message,
    int? page,
    bool? hasReachMax,
    bool? isCaching,
    List<Recipe>? recipes,
  }) {
    return SearchState(
      status: status ?? this.status,
      query: query ?? this.query,
      message: message ?? this.message,
      page: page ?? this.page,
      hasReachMax: hasReachMax ?? this.hasReachMax,
      isCaching: isCaching ?? this.isCaching,
      recipes: recipes ?? this.recipes,
    );
  }


  @override
  List<Object> get props 
    => [status, query, page, recipes, hasReachMax, isCaching, message];
}
