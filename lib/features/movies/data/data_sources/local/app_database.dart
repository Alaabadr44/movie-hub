import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../models/res/base_movie_res_model.dart';
import 'DAO/movie_dao.dart';
import 'types-converter/genre_converter.dart';

part 'app_database.g.dart';
@TypeConverters([GenreConverter])
// @TypeConverters([MovieResModelConverter])

@Database(version: 1, entities: [MovieResModel])
abstract class AppDatabase extends FloorDatabase {
  MovieDao get moviesDAO;
}
