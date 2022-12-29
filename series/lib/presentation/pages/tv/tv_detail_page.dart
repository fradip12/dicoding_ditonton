import 'package:cached_network_image/cached_network_image.dart';
import 'package:common/common.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/features/movies/domain/entities/genre.dart';
import 'package:movies/features/movies/presentation/bloc/movie/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:series/domain/entities/tv/tv.dart';
import '../../../domain/entities/tv/tv_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../bloc/tv/tv_detail_bloc/tv_detail_bloc.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv_detail';

  final int id;
  TvDetailPage({required this.id});

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvDetailBloc>().add(OnTvDetailLoad(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvDetailBloc, TvDetailState>(
        builder: (_, state) {
          if (state is TvDetailEmpty) {
            return Container();
          } else if (state is TvDetailLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TvDetailLoaded) {
            final movie = state.result;
            final recommend = state.recommendations;
            final status = state.isAddedToWatchlist;
            return SafeArea(
              child: DetailTvContent(
                movie,
                status,
                recommend,
              ),
            );
          } else if (state is WatchlistTvDialog) {
            return const CircularProgressIndicator();
          } else {
            return Text((state as TvDetailError).message);
          }
        },
      ),
    );
  }
}

class DetailTvContent extends StatelessWidget {
  final TvDetail movie;
  final List<TV> recommendations;
  final bool isAddedWatchlist;
  DetailTvContent(
    this.movie,
    this.isAddedWatchlist,
    this.recommendations,
  );
  _showSnack(BuildContext context, String message) {
    var snackBar = SnackBar(
      content: Text(
        message,
        style: kBodyText.copyWith(color: kPrussianBlue),
      ),
      backgroundColor: Colors.white,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.name ?? '-',
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  context
                                      .read<TvDetailBloc>()
                                      .add(OnAddTvtoWatchlist(movie));
                                  _showSnack(
                                      context, watchlistAddSuccessMessage);
                                } else {
                                  context
                                      .read<TvDetailBloc>()
                                      .add(OnTvRemoveWatchlist(movie));
                                  _showSnack(
                                      context, watchlistRemoveSuccessMessage);
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(movie.genres!),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage != null
                                      ? movie.voteAverage! / 2
                                      : 0,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview ?? '-',
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Season & Episode',
                              style: kHeading6,
                            ),
                            seasonEpisode(
                                context, movie.seasons ?? [], scrollController),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final movie = recommendations[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                          context,
                                          TvDetailPage.ROUTE_NAME,
                                          arguments: movie.id,
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: recommendations.length,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  Widget seasonEpisode(
    BuildContext context,
    List<Season> season,
    final ScrollController controller,
  ) {
    final screenHeight = MediaQuery.of(context).size.height;
    if (season.isEmpty) {
      return Container();
    }
    return SizedBox(
      height: screenHeight / 3.5,
      child: ListView.builder(
          controller: controller,
          shrinkWrap: true,
          itemCount: season.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (_, i) {
            return ExpansionTile(
              title: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                      width: 50,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Flexible(
                    flex: 4,
                    child: Text(
                      season[i].name ?? '-',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              children: <Widget>[
                ListTile(
                  title: Row(
                    children: [
                      Flexible(flex: 1, child: Container()),
                      Flexible(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total : ${season[i].episodeCount ?? 0} episode',
                              style: kBodyText,
                            ),
                            Text(
                              season[i].overview ?? '',
                              style: kBodyText,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
