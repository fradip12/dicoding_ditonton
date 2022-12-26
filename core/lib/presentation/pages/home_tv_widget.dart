import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/presentation/bloc/tv/tv_list_bloc/tv_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:core/core.dart';

class HomeTv extends StatefulWidget {
  @override
  State<HomeTv> createState() => _HomeTvState();
}

class _HomeTvState extends State<HomeTv> {
  @override
  void initState() {
    super.initState();
    context.read<TvListBloc>().add(OnLoadTvList());
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
            BlocBuilder<TvListBloc, TvListState>(
              builder: (_, state) {
                if (state is TvListInitial) {
                  return Container();
                } else if (state is TvListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvListLoaded) {
                  return TvList(
                    state.nowplaying,
                    state.nowPlayingState,
                  );
                } else {
                  return Text((state as MovieDetailError).message);
                }
              },
            ),
            _buildSubHeading(
                title: "Popular",
                onTap: () {
                  Navigator.pushNamed(context, PopularTvPage.ROUTE_NAME);
                }),
            BlocBuilder<TvListBloc, TvListState>(
              builder: (_, state) {
                if (state is TvListInitial) {
                  return Container();
                } else if (state is TvListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvListLoaded) {
                  return TvList(
                    state.popular,
                    state.popularState,
                  );
                } else {
                  return Text((state as MovieDetailError).message);
                }
              },
            ),
            _buildSubHeading(
                title: "Top Rated",
                onTap: () {
                  Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME);
                }),
            BlocBuilder<TvListBloc, TvListState>(
              builder: (_, state) {
                if (state is TvListInitial) {
                  return Container();
                } else if (state is TvListLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvListLoaded) {
                  return TvList(
                    state.topRated,
                    state.topRatedState,
                  );
                } else {
                  return Text((state as MovieDetailError).message);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TvList extends StatelessWidget {
  final List<TV> movies;
  final RequestState state;
  const TvList(this.movies, this.state, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state == RequestState.Error) {
      return const Text('Failed');
    }
    return SizedBox(
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
