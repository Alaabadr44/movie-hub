import 'dart:convert';

import 'package:floor/floor.dart';

import '../../../models/res/genres_res_model.dart';

// genre_converter
class GenreConverter extends TypeConverter<List<Genre>, String> {
  static const String _nullS = "NULL";
  @override
  List<Genre> decode(String databaseValue) {
    if (databaseValue.isEmpty || databaseValue == _nullS) {
      return [];
    } else {
      return List<Genre>.from(jsonDecode(databaseValue)!.map((x) {
        if (x is String) {
          return Genre.fromJson(x);
        } else {
          return Genre.fromMap(x);
        }
      }));
    }
  }

  @override
  String encode(List<Genre> value) {
    if ((value.isEmpty)) {
      return _nullS;
    } else {
      final List<String> _json = [];
      for (var e in value) {
        _json.add(e.toJson());
      }
      return jsonEncode(_json);
    }
  }
}
