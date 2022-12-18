import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/enum.dart';
import 'package:ditonton/presentation/pages/home_tv_widget.dart';
import 'package:flutter/material.dart';

import '../../common/constants.dart';
import '../../domain/entities/movie.dart';
import 'about_page.dart';
import 'home_movie_widget.dart';
import 'movie_detail_page.dart';
import 'search_page.dart';
import 'watchlist_movies_page.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  int _selectedIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new HomeMovie();
      case 1:
        return new HomeTv();

      default:
        return new Text("Error");
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
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
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
                SearchPage.ROUTE_NAME,
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
