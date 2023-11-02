class Api {
  static const String baseUrl = 'https://13.51.238.100:8084';

  // static const String baseUrl = 'http://10.0.2.2:8084';
  static const String users = '$baseUrl/saur/stockists';

  static const String login = '$baseUrl/saur/stockists/authenticate';

  static const String getWarrantFromCrm =
      '$baseUrl/saur/warrantyDetails/stockist/crm/';

  static const String dealers = '$baseUrl/saur/dealers';

  static const String allocateToDealers = '$baseUrl/saur/warrantyDetails/all';

  static const String deleteWarrantyRequest = '$baseUrl/saur/warrantyDetails/';

  static const String warrantyByStockist =
      '$baseUrl/saur/warrantyDetails/stockist/';

  static const String validateStockist = '$baseUrl/saur/stockists/crm/?';
  static const String validateStockist2 = '$baseUrl/saur/sdw/crm/?';
  static const String getWarrantyByStockistCode = '$baseUrl/saur/sdw/crm/?';
  static const String allocateToDealer = '$baseUrl/saur/sdw/';
  static const String deviceDetailFromCrm =
      '$baseUrl/saur/warrantyDetails/crm/';

  static String buildOtpUrl(String phone, String otp) {
    return 'https://sms.voicesoft.in/vb/apikey.php?apikey=UaOLHBZP2GxUy3ZN&senderid=SSSPLM&number=$phone&unicode=2&message=Your%20OTP%20for%20phone%20verification%20on%20Sudarshan%20Saur%20Application%20is%20$otp';
  }
}
