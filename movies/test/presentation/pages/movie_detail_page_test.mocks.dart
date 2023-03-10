// Mocks generated by Mockito 5.2.0 from annotations
// in movies/test/presentation/pages/movie_detail_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:flutter_bloc/flutter_bloc.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movies/features/movies/domain/usecases/get_movie_detail.dart'
    as _i2;
import 'package:movies/features/movies/domain/usecases/get_movie_recommendations.dart'
    as _i3;
import 'package:movies/features/movies/presentation/bloc/movie/movie_detail_bloc/movie_detail_bloc.dart'
    as _i5;
import 'package:watchlist/watchlist.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeGetMovieDetail_0 extends _i1.Fake implements _i2.GetMovieDetail {}

class _FakeGetMovieRecommendations_1 extends _i1.Fake
    implements _i3.GetMovieRecommendations {}

class _FakeGetWatchListStatus_2 extends _i1.Fake
    implements _i4.GetWatchListStatus {}

class _FakeSaveWatchlist_3 extends _i1.Fake implements _i4.SaveWatchlist {}

class _FakeRemoveWatchlist_4 extends _i1.Fake implements _i4.RemoveWatchlist {}

class _FakeMovieDetailState_5 extends _i1.Fake implements _i5.MovieDetailState {
}

/// A class which mocks [MovieDetailBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieDetailBloc extends _i1.Mock implements _i5.MovieDetailBloc {
  MockMovieDetailBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetMovieDetail get getMovieDetail =>
      (super.noSuchMethod(Invocation.getter(#getMovieDetail),
          returnValue: _FakeGetMovieDetail_0()) as _i2.GetMovieDetail);
  @override
  _i3.GetMovieRecommendations get getMovieRecommendations =>
      (super.noSuchMethod(Invocation.getter(#getMovieRecommendations),
              returnValue: _FakeGetMovieRecommendations_1())
          as _i3.GetMovieRecommendations);
  @override
  _i4.GetWatchListStatus get getWatchListStatus =>
      (super.noSuchMethod(Invocation.getter(#getWatchListStatus),
          returnValue: _FakeGetWatchListStatus_2()) as _i4.GetWatchListStatus);
  @override
  _i4.SaveWatchlist get saveWatchlist =>
      (super.noSuchMethod(Invocation.getter(#saveWatchlist),
          returnValue: _FakeSaveWatchlist_3()) as _i4.SaveWatchlist);
  @override
  _i4.RemoveWatchlist get removeWatchlist =>
      (super.noSuchMethod(Invocation.getter(#removeWatchlist),
          returnValue: _FakeRemoveWatchlist_4()) as _i4.RemoveWatchlist);
  @override
  _i5.MovieDetailState get state =>
      (super.noSuchMethod(Invocation.getter(#state),
          returnValue: _FakeMovieDetailState_5()) as _i5.MovieDetailState);
  @override
  _i6.Stream<_i5.MovieDetailState> get stream =>
      (super.noSuchMethod(Invocation.getter(#stream),
              returnValue: Stream<_i5.MovieDetailState>.empty())
          as _i6.Stream<_i5.MovieDetailState>);
  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);
  @override
  void add(_i5.MovieDetailEvent? event) =>
      super.noSuchMethod(Invocation.method(#add, [event]),
          returnValueForMissingStub: null);
  @override
  void onEvent(_i5.MovieDetailEvent? event) =>
      super.noSuchMethod(Invocation.method(#onEvent, [event]),
          returnValueForMissingStub: null);
  @override
  void emit(_i5.MovieDetailState? state) =>
      super.noSuchMethod(Invocation.method(#emit, [state]),
          returnValueForMissingStub: null);
  @override
  void on<E extends _i5.MovieDetailEvent>(
          _i7.EventHandler<E, _i5.MovieDetailState>? handler,
          {_i7.EventTransformer<E>? transformer}) =>
      super.noSuchMethod(
          Invocation.method(#on, [handler], {#transformer: transformer}),
          returnValueForMissingStub: null);
  @override
  void onTransition(
          _i7.Transition<_i5.MovieDetailEvent, _i5.MovieDetailState>?
              transition) =>
      super.noSuchMethod(Invocation.method(#onTransition, [transition]),
          returnValueForMissingStub: null);
  @override
  _i6.Future<void> close() => (super.noSuchMethod(Invocation.method(#close, []),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  void onChange(_i7.Change<_i5.MovieDetailState>? change) =>
      super.noSuchMethod(Invocation.method(#onChange, [change]),
          returnValueForMissingStub: null);
  @override
  void addError(Object? error, [StackTrace? stackTrace]) =>
      super.noSuchMethod(Invocation.method(#addError, [error, stackTrace]),
          returnValueForMissingStub: null);
  @override
  void onError(Object? error, StackTrace? stackTrace) =>
      super.noSuchMethod(Invocation.method(#onError, [error, stackTrace]),
          returnValueForMissingStub: null);
}
