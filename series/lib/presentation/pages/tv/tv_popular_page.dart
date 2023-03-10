import 'package:common/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/tv/tv_list_bloc/tv_list_bloc.dart';
import '../../widgets/tv_card_list.dart';

class PopularTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';

  @override
  _PopularTvPageState createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {
  @override
  void initState() {
    super.initState();
    context.read<TvListBloc>().add(OnLoadTvList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvListBloc, TvListState>(
          builder: (_, state) {
            if (state is TvListInitial) {
              return Container();
            } else if (state is TvListLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvListLoaded) {
              final data = state.popular;
              if (state.popularState == RequestState.error) {
                return const Text('Failed');
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data[index];
                  return TvCard(movie);
                },
                itemCount: data.length,
              );
            } else {
              return Text((state as TvListError).message);
            }
          },
        ),
      ),
    );
  }
}
