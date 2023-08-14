// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MovieDao? _moviesDAOInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `movie` (`movieImage` TEXT, `title` TEXT, `description` TEXT, `voteAverage` REAL, `voteCount` INTEGER, `id` INTEGER, `genres` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MovieDao get moviesDAO {
    return _moviesDAOInstance ??= _$MovieDao(database, changeListener);
  }
}

class _$MovieDao extends MovieDao {
  _$MovieDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _movieResModelInsertionAdapter = InsertionAdapter(
            database,
            'movie',
            (MovieResModel item) => <String, Object?>{
                  'movieImage': item.movieImage,
                  'title': item.title,
                  'description': item.description,
                  'voteAverage': item.voteAverage,
                  'voteCount': item.voteCount,
                  'id': item.id,
                  'genres': _genreConverter.encode(item.genres)
                }),
        _movieResModelDeletionAdapter = DeletionAdapter(
            database,
            'movie',
            ['id'],
            (MovieResModel item) => <String, Object?>{
                  'movieImage': item.movieImage,
                  'title': item.title,
                  'description': item.description,
                  'voteAverage': item.voteAverage,
                  'voteCount': item.voteCount,
                  'id': item.id,
                  'genres': _genreConverter.encode(item.genres)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MovieResModel> _movieResModelInsertionAdapter;

  final DeletionAdapter<MovieResModel> _movieResModelDeletionAdapter;

  @override
  Future<List<MovieResModel>> getFavoritesMovies() async {
    return _queryAdapter.queryList('SELECT * FROM movie',
        mapper: (Map<String, Object?> row) => MovieResModel(
            genres: _genreConverter.decode(row['genres'] as String),
            id: row['id'] as int?,
            description: row['description'] as String?,
            movieImage: row['movieImage'] as String?,
            title: row['title'] as String?,
            voteAverage: row['voteAverage'] as double?,
            voteCount: row['voteCount'] as int?));
  }

  @override
  Future<void> insertMovie(MovieResModel article) async {
    await _movieResModelInsertionAdapter.insert(
        article, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteMovie(MovieResModel articleModel) async {
    await _movieResModelDeletionAdapter.delete(articleModel);
  }
}

// ignore_for_file: unused_element
final _genreConverter = GenreConverter();
