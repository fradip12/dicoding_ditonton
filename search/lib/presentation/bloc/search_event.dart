part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class OnQueryChanged extends SearchEvent {
  final String query;
  final SearchType type;
  const OnQueryChanged(this.query, this.type);

  @override
  List<Object> get props => [query];
}
