import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/tv/tv_nowplaying_page.dart';
import 'package:ditonton/presentation/pages/tv/tv_popular_page.dart';
import 'package:ditonton/presentation/pages/tv/tv_toprated_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/constants.dart';
import '../../common/state_enum.dart';
import '../../domain/entities/tv/tv.dart';
import '../provider/tv/tv_list_notifier.dart';
import 'tv/tv_detail_page.dart';

class HomeTv extends StatefulWidget {
  @override
  State<HomeTv> createState() => _HomeTvState();
}

class _HomeTvState extends State<HomeTv> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<TvListNotifier>(context, listen: false)
      ..fetchNowPlayingMovies()
      ..fetchPopularMovies()
      ..fetchTopRatedMovies());
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubHeading(
                title: "Now Playing",
                onTap: () {
                  Navigator.pushNamed(context, NowPlayingTvPage.ROUTE_NAME);
                }),
            Consumer<TvListNotifier>(builder: (context, data, child) {
              final state = data.nowPlayingState;
              if (state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return TvList(data.nowPlayingMovies);
              } else {
                return Text('Failed');
              }
            }),
            _buildSubHeading(
                title: "Popular",
                onTap: () {
                  Navigator.pushNamed(context, PopularTvPage.ROUTE_NAME);
                }),
            Consumer<TvListNotifier>(builder: (context, data, child) {
              final state = data.popularMoviesState;
              if (state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return TvList(data.popularMovies);
              } else {
                return Text('Failed');
              }
            }),
            _buildSubHeading(
                title: "Top Rated",
                onTap: () {
                  Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME);
                }),
            Consumer<TvListNotifier>(builder: (context, data, child) {
              final state = data.topRatedMoviesState;
              if (state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                return TvList(data.topRatedMovies);
              } else {
                return Text('Failed');
              }
            }),
          ],
        ),
      ),
    );
  }
}

class TvList extends StatelessWidget {
  final List<TV> movies;

  TvList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
