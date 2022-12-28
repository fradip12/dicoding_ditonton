import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:series/presentation/pages/home_tv_widget.dart';
import 'package:watchlist/watchlist.dart';

import 'home_movie_widget.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  int _selectedIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return  HomeMovie();
      case 1:
        return  HomeTv();

      default:
        return const Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedIndex = index);
    Navigator.of(context).pop();
  }

  _onNavigateSearch(int index) {
    switch (index) {
      case 0:
        return SearchType.MOVIES;
      case 1:
        return SearchType.TVSERIES;
      default:
        return SearchType.MOVIES;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                _onSelectItem(0);
              },
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('TV Series'),
              onTap: () {
                _onSelectItem(1);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, ABOUT_ROUTE);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                SEARCH_ROUTE,
                arguments: _onNavigateSearch(_selectedIndex),
              );
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: _getDrawerItemWidget(_selectedIndex),
    );
  }
}
