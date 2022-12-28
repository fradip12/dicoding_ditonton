import 'package:bloc/bloc.dart';
import 'package:common/utils/state_enum.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/tv/tv.dart';
import '../../../../domain/usecases/tv/get_tv_now_playing.dart';
import '../../../../domain/usecases/tv/get_tv_popular.dart';
import '../../../../domain/usecases/tv/get_tv_toprated.dart';

part 'tv_list_event.dart';
part 'tv_list_state.dart';

class TvListBloc extends Bloc<TvListEvent, TvListState> {
  final GetTvNowPlayingMovies getNowPlayingTv;
  final GetTvPopular getTvPopular;
  final GetTvTopRated getTvToprated;
  var nowPlayingState = RequestState.Empty;
  var nowPlayingMovies = <TV>[];
  var popularState = RequestState.Empty;
  var popularMovies = <TV>[];
  var topRatedState = RequestState.Empty;
  var topRatedMovies = <TV>[];

  TvListBloc(
    this.getNowPlayingTv,
    this.getTvPopular,
    this.getTvToprated,
  ) : super(TvListInitial()) {
    on<OnLoadTvList>(_onLoadAll);
  }

  Future<void> _onLoadAll(
    OnLoadTvList event,
    Emitter<TvListState> emit,
  ) async {
    emit(TvListLoading());
    final nowPlaying = await getNowPlayingTv.execute();
    final popular = await getTvPopular.execute();
    final topRated = await getTvToprated.execute();
    nowPlaying.fold((l) {
      nowPlayingState = RequestState.Error;
      return emit(TvListError(l.message));
    }, (r) {
      nowPlayingMovies = r;
      nowPlayingState = RequestState.Loaded;
      popular.fold((l) {
        popularState = RequestState.Error;
        return emit(TvListError(l.message));
      }, (r) {
        popularMovies = r;
        popularState = RequestState.Loaded;
        topRated.fold((l) {
          topRatedState = RequestState.Error;
          return emit(TvListError(l.message));
        }, (r) {
          topRatedMovies = r;
          topRatedState = RequestState.Loaded;
          return emit(
            TvListLoaded(
              nowPlayingMovies,
              popularMovies,
              topRatedMovies,
              nowPlayingState,
              popularState,
              topRatedState,
            ),
          );
        });
      });
    });
  }
}
