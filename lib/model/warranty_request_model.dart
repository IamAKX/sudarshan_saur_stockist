import 'dart:convert';

import 'package:saur_stockist/model/customer_model.dart';
import 'package:saur_stockist/model/warranty_model.dart';


class WarrantyRequestModel {
  CustomerModel? customers;
  String? mobile2;
  WarrantyModel? warrantyDetails;
  String? status;
  String? createdOn;
  String? updatedOn;
  String? initUserType;
  String? initiatedBy;
  String? approvedBy;
  String? installationDate;
  String? invoiceDate;
  String? invoiceNumber;
  String? lat;
  String? lon;
  bool? photoChecked;
  bool? otherInfoChecked;
  String? verifiedBy;
  String? verifiedDate;
  bool? paymentDone;
  WarrantyRequestModel({
    this.customers,
    this.mobile2,
    this.warrantyDetails,
    this.status,
    this.createdOn,
    this.updatedOn,
    this.initUserType,
    this.initiatedBy,
    this.approvedBy,
    this.installationDate,
    this.invoiceDate,
    this.invoiceNumber,
    this.lat,
    this.lon,
    this.photoChecked,
    this.otherInfoChecked,
    this.verifiedBy,
    this.verifiedDate,
    this.paymentDone,
  });

  WarrantyRequestModel copyWith({
    CustomerModel? customers,
    String? mobile2,
    WarrantyModel? warrantyDetails,
    String? status,
    String? createdOn,
    String? updatedOn,
    String? initUserType,
    String? initiatedBy,
    String? approvedBy,
    String? installationDate,
    String? invoiceDate,
    String? invoiceNumber,
    String? lat,
    String? lon,
    bool? photoChecked,
    bool? otherInfoChecked,
    String? verifiedBy,
    String? verifiedDate,
    bool? paymentDone,
  }) {
    return WarrantyRequestModel(
      customers: customers ?? this.customers,
      mobile2: mobile2 ?? this.mobile2,
      warrantyDetails: warrantyDetails ?? this.warrantyDetails,
      status: status ?? this.status,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
      initUserType: initUserType ?? this.initUserType,
      initiatedBy: initiatedBy ?? this.initiatedBy,
      approvedBy: approvedBy ?? this.approvedBy,
      installationDate: installationDate ?? this.installationDate,
      invoiceDate: invoiceDate ?? this.invoiceDate,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      photoChecked: photoChecked ?? this.photoChecked,
      otherInfoChecked: otherInfoChecked ?? this.otherInfoChecked,
      verifiedBy: verifiedBy ?? this.verifiedBy,
      verifiedDate: verifiedDate ?? this.verifiedDate,
      paymentDone: paymentDone ?? this.paymentDone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'customers': customers?.toMap(),
      'mobile2': mobile2,
      'warrantyDetails': warrantyDetails?.toMap(),
      'status': status,
      'createdOn': createdOn,
      'updatedOn': updatedOn,
      'initUserType': initUserType,
      'initiatedBy': initiatedBy,
      'approvedBy': approvedBy,
      'installationDate': installationDate,
      'invoiceDate': invoiceDate,
      'invoiceNumber': invoiceNumber,
      'lat': lat,
      'lon': lon,
      'photoChecked': photoChecked,
      'otherInfoChecked': otherInfoChecked,
      'verifiedBy': verifiedBy,
      'verifiedDate': verifiedDate,
      'paymentDone': paymentDone,
    };
  }

  factory WarrantyRequestModel.fromMap(Map<String, dynamic> map) {
    return WarrantyRequestModel(
      customers: map['customers'] != null
          ? CustomerModel.fromMap(map['customers'])
          : null,
      mobile2: map['mobile2'],
      warrantyDetails: map['warrantyDetails'] != null
          ? WarrantyModel.fromMap(map['warrantyDetails'])
          : null,
      status: map['status'],
      createdOn: map['createdOn'],
      updatedOn: map['updatedOn'],
      initUserType: map['initUserType'],
      initiatedBy: map['initiatedBy'],
      approvedBy: map['approvedBy'],
      installationDate: map['installationDate'],
      invoiceDate: map['invoiceDate'],
      invoiceNumber: map['invoiceNumber'],
      lat: map['lat'],
      lon: map['lon'],
      photoChecked: map['photoChecked'],
      otherInfoChecked: map['otherInfoChecked'],
      verifiedBy: map['verifiedBy'],
      verifiedDate: map['verifiedDate'],
      paymentDone: map['paymentDone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WarrantyRequestModel.fromJson(String source) =>
      WarrantyRequestModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WarrantyRequestModel(customers: $customers, mobile2: $mobile2, warrantyDetails: $warrantyDetails, status: $status, createdOn: $createdOn, updatedOn: $updatedOn, initUserType: $initUserType, initiatedBy: $initiatedBy, approvedBy: $approvedBy, installationDate: $installationDate, invoiceDate: $invoiceDate, invoiceNumber: $invoiceNumber, lat: $lat, lon: $lon, photoChecked: $photoChecked, otherInfoChecked: $otherInfoChecked, verifiedBy: $verifiedBy, verifiedDate: $verifiedDate, paymentDone: $paymentDone)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WarrantyRequestModel &&
        other.customers == customers &&
        other.mobile2 == mobile2 &&
        other.warrantyDetails == warrantyDetails &&
        other.status == status &&
        other.createdOn == createdOn &&
        other.updatedOn == updatedOn &&
        other.initUserType == initUserType &&
        other.initiatedBy == initiatedBy &&
        other.approvedBy == approvedBy &&
        other.installationDate == installationDate &&
        other.invoiceDate == invoiceDate &&
        other.invoiceNumber == invoiceNumber &&
        other.lat == lat &&
        other.lon == lon &&
        other.photoChecked == photoChecked &&
        other.otherInfoChecked == otherInfoChecked &&
        other.verifiedBy == verifiedBy &&
        other.verifiedDate == verifiedDate &&
        other.paymentDone == paymentDone;
  }

  @override
  int get hashCode {
    return customers.hashCode ^
        mobile2.hashCode ^
        warrantyDetails.hashCode ^
        status.hashCode ^
        createdOn.hashCode ^
        updatedOn.hashCode ^
        initUserType.hashCode ^
        initiatedBy.hashCode ^
        approvedBy.hashCode ^
        installationDate.hashCode ^
        invoiceDate.hashCode ^
        invoiceNumber.hashCode ^
        lat.hashCode ^
        lon.hashCode ^
        photoChecked.hashCode ^
        otherInfoChecked.hashCode ^
        verifiedBy.hashCode ^
        verifiedDate.hashCode ^
        paymentDone.hashCode;
  }
}
