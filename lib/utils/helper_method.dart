import 'package:saur_stockist/model/warranty_model.dart';

import '../model/address_model.dart';

getWarantyLabel(WarrantyModel? warrantyModel) {
  return '${warrantyModel?.itemDescription ?? ''} ';
}

String prepareAddress(AddressModel? address) {
  return '${address?.addressLine1}, ${address?.addressLine2}, ${address?.city}, ${address?.state} - ${address?.zipCode}';
}
