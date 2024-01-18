import 'dart:convert';

import 'address_model.dart';

class DealerModel {
  int? dealerId;
  String? dealerName;
  String? password;
  String? mobileNo;
  String? status;
  String? email;
  AddressModel? address;
  String? image;
  String? lastLogin;
  String? businessName;
  String? businessAddress;
  String? gstNumber;
  String? updatedOn;
  String? createdOn;
  String? stockistCode;
  String? stockistBusinessName;
  DealerModel({
    this.dealerId,
    this.dealerName,
    this.password,
    this.mobileNo,
    this.status,
    this.email,
    this.address,
    this.image,
    this.lastLogin,
    this.businessName,
    this.businessAddress,
    this.gstNumber,
    this.updatedOn,
    this.createdOn,
    this.stockistCode,
    this.stockistBusinessName,
  });

  DealerModel copyWith({
    int? dealerId,
    String? dealerName,
    String? password,
    String? mobileNo,
    String? status,
    String? email,
    AddressModel? address,
    String? image,
    String? lastLogin,
    String? businessName,
    String? businessAddress,
    String? gstNumber,
    String? updatedOn,
    String? createdOn,
    String? stockistCode,
    String? stockistBusinessName,
  }) {
    return DealerModel(
      dealerId: dealerId ?? this.dealerId,
      dealerName: dealerName ?? this.dealerName,
      password: password ?? this.password,
      mobileNo: mobileNo ?? this.mobileNo,
      status: status ?? this.status,
      email: email ?? this.email,
      address: address ?? this.address,
      image: image ?? this.image,
      lastLogin: lastLogin ?? this.lastLogin,
      businessName: businessName ?? this.businessName,
      businessAddress: businessAddress ?? this.businessAddress,
      gstNumber: gstNumber ?? this.gstNumber,
      updatedOn: updatedOn ?? this.updatedOn,
      createdOn: createdOn ?? this.createdOn,
      stockistCode: stockistCode ?? this.stockistCode,
      stockistBusinessName: stockistBusinessName ?? this.stockistBusinessName,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(dealerId != null){
      result.addAll({'dealerId': dealerId});
    }
    if(dealerName != null){
      result.addAll({'dealerName': dealerName});
    }
    if(password != null){
      result.addAll({'password': password});
    }
    if(mobileNo != null){
      result.addAll({'mobileNo': mobileNo});
    }
    if(status != null){
      result.addAll({'status': status});
    }
    if(email != null){
      result.addAll({'email': email});
    }
    if(address != null){
      result.addAll({'address': address!.toMap()});
    }
    if(image != null){
      result.addAll({'image': image});
    }
    if(lastLogin != null){
      result.addAll({'lastLogin': lastLogin});
    }
    if(businessName != null){
      result.addAll({'businessName': businessName});
    }
    if(businessAddress != null){
      result.addAll({'businessAddress': businessAddress});
    }
    if(gstNumber != null){
      result.addAll({'gstNumber': gstNumber});
    }
    if(updatedOn != null){
      result.addAll({'updatedOn': updatedOn});
    }
    if(createdOn != null){
      result.addAll({'createdOn': createdOn});
    }
    if(stockistCode != null){
      result.addAll({'stockistCode': stockistCode});
    }
    if(stockistBusinessName != null){
      result.addAll({'stockistBusinessName': stockistBusinessName});
    }
  
    return result;
  }

  factory DealerModel.fromMap(Map<String, dynamic> map) {
    return DealerModel(
      dealerId: map['dealerId']?.toInt(),
      dealerName: map['dealerName'],
      password: map['password'],
      mobileNo: map['mobileNo'],
      status: map['status'],
      email: map['email'],
      address: map['address'] != null ? AddressModel.fromMap(map['address']) : null,
      image: map['image'],
      lastLogin: map['lastLogin'],
      businessName: map['businessName'],
      businessAddress: map['businessAddress'],
      gstNumber: map['gstNumber'],
      updatedOn: map['updatedOn'],
      createdOn: map['createdOn'],
      stockistCode: map['stockistCode'],
      stockistBusinessName: map['stockistBusinessName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DealerModel.fromJson(String source) => DealerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DealerModel(dealerId: $dealerId, dealerName: $dealerName, password: $password, mobileNo: $mobileNo, status: $status, email: $email, address: $address, image: $image, lastLogin: $lastLogin, businessName: $businessName, businessAddress: $businessAddress, gstNumber: $gstNumber, updatedOn: $updatedOn, createdOn: $createdOn, stockistCode: $stockistCode, stockistBusinessName: $stockistBusinessName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DealerModel &&
      other.dealerId == dealerId &&
      other.dealerName == dealerName &&
      other.password == password &&
      other.mobileNo == mobileNo &&
      other.status == status &&
      other.email == email &&
      other.address == address &&
      other.image == image &&
      other.lastLogin == lastLogin &&
      other.businessName == businessName &&
      other.businessAddress == businessAddress &&
      other.gstNumber == gstNumber &&
      other.updatedOn == updatedOn &&
      other.createdOn == createdOn &&
      other.stockistCode == stockistCode &&
      other.stockistBusinessName == stockistBusinessName;
  }

  @override
  int get hashCode {
    return dealerId.hashCode ^
      dealerName.hashCode ^
      password.hashCode ^
      mobileNo.hashCode ^
      status.hashCode ^
      email.hashCode ^
      address.hashCode ^
      image.hashCode ^
      lastLogin.hashCode ^
      businessName.hashCode ^
      businessAddress.hashCode ^
      gstNumber.hashCode ^
      updatedOn.hashCode ^
      createdOn.hashCode ^
      stockistCode.hashCode ^
      stockistBusinessName.hashCode;
  }
}
