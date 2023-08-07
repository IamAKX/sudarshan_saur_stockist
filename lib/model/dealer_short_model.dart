import 'dart:convert';

class DealerShortModel {
  String? name;
  String? image;
  int? id;
  int? count;
  DealerShortModel({
    this.name,
    this.image,
    this.id,
    this.count,
  });

  DealerShortModel copyWith({
    String? name,
    String? image,
    int? id,
    int? count,
  }) {
    return DealerShortModel(
      name: name ?? this.name,
      image: image ?? this.image,
      id: id ?? this.id,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'id': id,
      'count': count,
    };
  }

  factory DealerShortModel.fromMap(Map<String, dynamic> map) {
    return DealerShortModel(
      name: map['name'],
      image: map['image'],
      id: map['id']?.toInt(),
      count: map['count']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory DealerShortModel.fromJson(String source) => DealerShortModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DealerShortModel(name: $name, image: $image, id: $id, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DealerShortModel &&
      other.name == name &&
      other.image == image &&
      other.id == id &&
      other.count == count;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      image.hashCode ^
      id.hashCode ^
      count.hashCode;
  }
}
