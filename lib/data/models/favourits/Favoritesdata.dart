import 'Favorites.dart';

class Favoritesdata {
  Favoritesdata({
      this.favorites,});

  Favoritesdata.fromJson(dynamic json) {
    if (json['favorites'] != null) {
      favorites = [];
      json['favorites'].forEach((v) {
        favorites!.add(Favorites.fromJson(v));
      });
    }
  }
  List<Favorites>? favorites;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (favorites != null) {
      map['favorites'] = favorites!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}