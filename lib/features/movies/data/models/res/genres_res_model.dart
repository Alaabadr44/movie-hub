import 'dart:convert';

import '../../../../../core/resources/base_response.dart';

// genres_res_model
class GenresResModel extends BaseResponse {
  List<Genre> genres;
  GenresResModel({
    required this.genres,
  });

  factory GenresResModel.fromJson(Map<String, dynamic> map) {
    return GenresResModel(
      genres: List<Genre>.from(map['genres']?.map((x) {
        if (x is String) {
          return Genre.fromJson(x);
        } else {
          return Genre.fromMap(x);
        }
      })),
    );
  }

  // String toJson() => json.encode(toMap());

  // factory GenresResModel.fromJson(String source) =>
  //     GenresResModel.fromMap(json.decode(source));
}

class Genre {
  int id;
  String name;
  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromMap(Map<String, dynamic> map) {
    return Genre(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
    );
  }

  toMap() => {
        "id": id,
        "name": name,
      };

  factory Genre.fromJson(String source) {
    return Genre.fromMap(json.decode(source));
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return " id $id  name $name";
  }

  toMapEntry() {
    return MapEntry(id, name);
  }

  fromMapEntry(MapEntry mapEntry) => {
        id = mapEntry.key,
        name = mapEntry.value,
      };
}
