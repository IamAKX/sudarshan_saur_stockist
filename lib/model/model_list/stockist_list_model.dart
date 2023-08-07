import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../user_model.dart';

class StockistListModel {
  List<UserModel>? data;
  StockistListModel({
    this.data,
  });

  StockistListModel copyWith({
    List<UserModel>? data,
  }) {
    return StockistListModel(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data?.map((x) => x.toMap()).toList(),
    };
  }

  factory StockistListModel.fromMap(Map<String, dynamic> map) {
    return StockistListModel(
      data: map['data'] != null
          ? List<UserModel>.from(map['data']?.map((x) => UserModel.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StockistListModel.fromJson(String source) =>
      StockistListModel.fromMap(json.decode(source));

  @override
  String toString() => 'CustomerListModel(data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StockistListModel && listEquals(other.data, data);
  }

  @override
  int get hashCode => data.hashCode;
}
