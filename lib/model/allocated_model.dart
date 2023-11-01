import 'dart:convert';

import 'package:saur_stockist/model/dealer_model.dart';
import 'package:saur_stockist/model/warranty_model.dart';
import 'package:saur_stockist/model/warranty_request_model.dart';

class AllocatedModel {
  DealerModel? dealer;
  String? warrantySerialNo;
  WarrantyRequestModel? warrantyRequests;
  AllocatedModel({
    this.dealer,
    this.warrantySerialNo,
    this.warrantyRequests,
  });

  AllocatedModel copyWith({
    DealerModel? dealer,
    String? warrantySerialNo,
    WarrantyRequestModel? warrantyRequests,
  }) {
    return AllocatedModel(
      dealer: dealer ?? this.dealer,
      warrantySerialNo: warrantySerialNo ?? this.warrantySerialNo,
      warrantyRequests: warrantyRequests ?? this.warrantyRequests,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dealer': dealer?.toMap(),
      'warrantySerialNo': warrantySerialNo,
      'warrantyRequests': warrantyRequests?.toMap(),
    };
  }

  factory AllocatedModel.fromMap(Map<String, dynamic> map) {
    return AllocatedModel(
      dealer: map['dealer'] != null ? DealerModel.fromMap(map['dealer']) : null,
      warrantySerialNo: map['warrantySerialNo'],
      warrantyRequests: map['warrantyRequests'] != null ? WarrantyRequestModel.fromMap(map['warrantyRequests']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AllocatedModel.fromJson(String source) => AllocatedModel.fromMap(json.decode(source));

  @override
  String toString() => 'AllocatedModel(dealer: $dealer, warrantySerialNo: $warrantySerialNo, warrantyRequests: $warrantyRequests)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AllocatedModel &&
      other.dealer == dealer &&
      other.warrantySerialNo == warrantySerialNo &&
      other.warrantyRequests == warrantyRequests;
  }

  @override
  int get hashCode => dealer.hashCode ^ warrantySerialNo.hashCode ^ warrantyRequests.hashCode;
}
