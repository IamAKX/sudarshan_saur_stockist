import 'dart:math';

import 'package:saur_stockist/model/warranty_model.dart';

import '../model/address_model.dart';


getWarantyLabel(WarrantyModel? warrantyModel) {
  return '${warrantyModel?.itemDescription ?? ''} ';
}


String getShortMessageByStatus(String status) {
  switch (status) {
    case 'PENDING':
      return 'Request in review';
    case 'APPROVED':
      return 'Request is approved';
    case 'DECLINED':
      return 'Request is rejected';
    default:
      return 'Request is ${status.toLowerCase()}';
  }
}

String getDetailedMessageByStatus(String status) {
  switch (status) {
    case 'PENDING':
      return 'Your request is under validation, you will be notified in 24 hours';
    case 'APPROVED':
      return 'Your warranty card is generated. You get download or get it on email or whatsapp.';
    case 'DECLINED':
      return 'Your request is rejected by admin';
    default:
      return 'Request is ${status.toLowerCase()}';
  }
}

String prepareAddress(AddressModel? address) {
  return '';
  // '${address?.houseNo}, ${address?.area}, ${address?.street1}, ${address?.street2}, ${address?.landmark}, ${address?.taluk}, ${address?.town}, ${address?.state}, ${address?.zipCode}';
}

String getOTPCode() {
  return (Random().nextInt(900000) + 100000).toString();
}

bool isValidPhoneNumber(String number) {
  if (number.length != 10) return false;
  try {
    int.parse(number);
  } catch (e) {
    return false;
  }
  return true;
}

bool isValidZipcode(String number) {
  if (number.length != 6) return false;
  try {
    int.parse(number);
  } catch (e) {
    return false;
  }
  return true;
}

bool isValidSerialNumber(String number) {
  if (number.length != 6) return false;
  try {
    int.parse(number);
  } catch (e) {
    return false;
  }
  return true;
}
