
import 'package:common/common.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:rxdart/transformers.dart';
import 'package:series/series.dart';

import '../../domain/usecase/search_tv.dart';
import '../../search.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;
  final SearchSeries _searchSeries;

  SearchBloc(this._searchMovies, this._searchSeries) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;
      emit(SearchLoading());
      if (event.type == SearchType.MOVIES) {
        final result = await _searchMovies.execute(query);
        result.fold(
          (err) {
            emit(SearchError(err.message));
          },
          (data) {
            emit(SearchHasData(data));
          },
        );
      } else {
        final result = await _searchSeries.execute(query);
        result.fold(
          (err) {
            emit(SearchError(err.message));
          },
          (data) {
            emit(SearchTvHasData(data));
          },
        );
      }
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
