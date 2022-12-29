import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../dummy_data/dummy_objects.dart';

/// Initialize sqflite for test.
void sqfliteTestInit() {
  // Initialize ffi implementation
  sqfliteFfiInit();
  // Set global factory
  databaseFactory = databaseFactoryFfi;
}

Future main() async {
  const String _tblWatchlist = 'watchlist';
  const String _tblCache = 'cache';
  final movieJson = testMovieCache.toJson();
  movieJson["category"] = 'now-playing';
  sqfliteTestInit();
  var db = await openDatabase(
    _tblCache,
    version: 6,
  );
  group("test db helper", () {
    setUp(() async {
      //   await db.delete(_tblCache);

      //   await db.delete(_tblWatchlist);
      //   await db.execute('''
      //   CREATE TABLE  $_tblWatchlist (
      //     id INTEGER PRIMARY KEY,
      //     title TEXT,
      //     overview TEXT,
      //     posterPath TEXT
      //   );
      // ''');

      //   await db.execute('''
      //   CREATE TABLE  $_tblCache (
      //     id INTEGER PRIMARY KEY,
      //     title TEXT,
      //     overview TEXT,
      //     posterPath TEXT,
      //     category TEXT
      //   );
      // ''');
    });
    test('should return sqflite version same as setup', () async {
      expect(await db.getVersion(), 6);
    });
    test('should insert cache transaction to db', () async {
      await db.delete(_tblCache);
      var i = await db.insert(_tblCache, movieJson);
      var p = await db.query(_tblCache);
      expect(p.first, movieJson);
    });
    test('get cache movies should return List<Map<String,dynamic>> ', () async {
      // Clear first
      await db.delete(_tblCache);
      await db.insert(_tblCache, movieJson);
      var p = await db.query(
        _tblCache,
        where: 'category = ?',
        whereArgs: ['now-playing'],
      );
      expect(p, [movieJson]);
    });

    test('insert watchlist', () async {
      db.delete(_tblWatchlist);
      await db.insert(_tblWatchlist, testMovieCache.toJson());
      var p = await db.query(_tblWatchlist);
      expect(p.first, testMovieCache.toJson());
    });
  });
}
