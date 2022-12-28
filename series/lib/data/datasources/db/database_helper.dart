import 'dart:async';

import 'package:common/common.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import '../../models/tv/tv_table.dart';

class DatabaseSeriesHelper {
  static DatabaseSeriesHelper? _databaseHelper;
  DatabaseSeriesHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseSeriesHelper() => _databaseHelper ?? DatabaseSeriesHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const String _tblTvWatchlist = 'tvwatchlist';
  static const String _tblTvCache = 'tvcache';
  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton_series.db';

    var db = await openDatabase(
      databasePath,
      version: 5,
      onCreate: _onCreate,
      password: encrypt('ditonton-fradip-password-encrypt'),
    );
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblTvWatchlist (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE  $_tblTvCache (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT,
        category TEXT
      );
    ''');
  }

  Future<void> insertTvCacheTransaction(
      List<TvTable> series, String category) async {
    final db = await database;
    db!.transaction((txn) async {
      for (final tv in series) {
        final tvJson = tv.toJson();
        tvJson['category'] = category;
        txn.insert(
          _tblTvCache,
          tvJson,
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<List<Map<String, dynamic>>> getCacheTv(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(
      _tblTvCache,
      where: 'category = ?',
      whereArgs: [category],
    );
    return results;
  }

  Future<int> clearTvCache(String category) async {
    final db = await database;
    return await db!.delete(
      _tblTvCache,
      where: 'category = ?',
      whereArgs: [category],
    );
  }

  Future<int> insertTvWatchlist(TvTable series) async {
    final db = await database;
    return await db!.insert(_tblTvWatchlist, series.toJson());
  }

  Future<int> removeTvWatchlist(TvTable movie) async {
    final db = await database;
    return await db!.delete(
      _tblTvWatchlist,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getTvById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblTvWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTv() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblTvWatchlist);

    return results;
  }
}
