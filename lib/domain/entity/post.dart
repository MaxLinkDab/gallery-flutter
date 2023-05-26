import 'dart:convert';

enum Trend { news, popular }

class Post {
  final int id;
  final String name;
  final String dateCreate;
  final String description;
  final Image? image;
  final String user;

  Post(
    this.id,
    this.name,
    this.dateCreate,
    this.description,
    this.image,
    this.user,
  );

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'dateCreate': dateCreate});
    result.addAll({'description': description});
    if (image != null) {
      result.addAll({'image': image!.toMap()});
    }
    result.addAll({'user': user});

    return result;
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      map['id']?.toInt() ?? 0,
      map['name'] ?? '',
      map['dateCreate'] ?? '',
      map['description'] ?? '',
      map['image'] != null ? Image.fromMap(map['image']) : null,
      map['user'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  Post copyWith({
    int? id,
    String? name,
    String? dateCreate,
    String? description,
    Image? image,
    String? user,
  }) {
    return Post(
      id ?? this.id,
      name ?? this.name,
      dateCreate ?? this.dateCreate,
      description ?? this.description,
      image ?? this.image,
      user ?? this.user,
    );
  }
}

class Image {
  int id;
  String name;
  Image({
    required this.id,
    required this.name,
  });

  Image copyWith({
    int? id,
    String? name,
  }) {
    return Image(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});

    return result;
  }

  factory Image.fromMap(Map<String, dynamic> map) {
    return Image(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Image.fromJson(String source) => Image.fromMap(json.decode(source));
}
