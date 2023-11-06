import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:saur_stockist/model/model_list/allocated_list.dart';
import 'package:saur_stockist/model/model_list/dealer_list_model.dart';
import 'package:saur_stockist/model/model_list/stockist_list_model.dart';
import 'package:saur_stockist/model/warranty_model.dart';

import '../main.dart';
import '../model/model_list/warranty_request_list.dart';
import '../model/user_model.dart';
import '../utils/api.dart';
import '../utils/enum.dart';
import '../utils/preference_key.dart';
import 'snakbar_service.dart';

enum ApiStatus { ideal, loading, success, failed }

class ApiProvider extends ChangeNotifier {
  ApiStatus? status = ApiStatus.ideal;
  late Dio _dio;
  static ApiProvider instance = ApiProvider();
  String code = '';

  ApiProvider() {
    _dio = Dio();
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
        HttpClient()
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;
  }

  Future<bool> createUser(UserModel user) async {
    status = ApiStatus.loading;
    notifyListeners();
    try {
      Map<String, dynamic> reqBody = user.toMap();

      log('Request : ${json.encode(reqBody)}');
      Response response = await _dio.post(
        Api.users,
        data: json.encode(reqBody),
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        UserModel user = UserModel.fromMap(response.data['data']);
        prefs.setInt(SharedpreferenceKey.userId, user.stockistId ?? 0);
        if (user.status == UserStatus.ACTIVE.name) {
          status = ApiStatus.success;
          notifyListeners();
        } else {
          status = ApiStatus.failed;
          notifyListeners();
        }
        return true;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
      SnackBarService.instance
          .showSnackBarError('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      SnackBarService.instance.showSnackBarError(e.toString());
      log(e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return false;
  }

  Future<UserModel?> login(String email, String password) async {
    status = ApiStatus.loading;
    UserModel? userModel;
    notifyListeners();
    try {
      Map<String, dynamic> map = {'email': email, 'password': password};
      log('request : ${json.encode(map)}');
      Response response = await _dio.post(
        Api.login,
        data: json.encode(map),
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        userModel = UserModel.fromMap(response.data['data']);
        prefs.setInt(SharedpreferenceKey.userId, userModel.stockistId ?? 0);
        status = ApiStatus.success;
        notifyListeners();
        return userModel;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
      SnackBarService.instance
          .showSnackBarError('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();

      SnackBarService.instance.showSnackBarError(e.toString());
      log(e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return userModel;
  }

  Future<bool> updateUser(Map<String, dynamic> user, int id) async {
    status = ApiStatus.loading;
    notifyListeners();
    try {
      log('id : $id');
      log('Request  : ${json.encode(user)}');
      Response response = await _dio.put(
        '${Api.users}/$id',
        data: json.encode(user),
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        UserModel user = UserModel.fromMap(response.data['data']);
        prefs.setInt(SharedpreferenceKey.userId, user.stockistId ?? 0);
        status = ApiStatus.success;
        notifyListeners();
        return true;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
      SnackBarService.instance
          .showSnackBarError('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      SnackBarService.instance.showSnackBarError(e.toString());
      log(e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return false;
  }

  Future<UserModel?> getStockistById(int id) async {
    status = ApiStatus.loading;
    notifyListeners();
    UserModel? userModel;
    log('${Api.users}/$id');
    try {
      Response response = await _dio.get(
        '${Api.users}/$id',
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        userModel = UserModel.fromMap(response.data['data']);
        status = ApiStatus.success;
        notifyListeners();
        return userModel;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
      // SnackBarService.instance
      //     .showSnackBarError('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      SnackBarService.instance.showSnackBarError(e.toString());
      log(e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return userModel;
  }

  Future<StockistListModel?> getAllStockist() async {
    status = ApiStatus.loading;
    notifyListeners();
    StockistListModel? list;
    try {
      Response response = await _dio.get(
        Api.users,
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        list = StockistListModel.fromMap(response.data);
        status = ApiStatus.success;
        notifyListeners();
        return list;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
      SnackBarService.instance
          .showSnackBarError('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      SnackBarService.instance.showSnackBarError(e.toString());
      log(e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return list;
  }

  Future<bool> sendOtp(String phone, String otp) async {
    status = ApiStatus.loading;
    notifyListeners();
    try {
      debugPrint(Api.buildOtpUrl(phone, otp));
      Response response = await _dio.get(
        Api.buildOtpUrl(phone, otp),
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        SnackBarService.instance.showSnackBarInfo('OTP sent');
        status = ApiStatus.success;
        notifyListeners();
        return true;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
      SnackBarService.instance
          .showSnackBarError('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      SnackBarService.instance.showSnackBarError(e.toString());
      log(e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return false;
  }

  Future<StockistListModel?> getStockistMobileNumber(String phone) async {
    status = ApiStatus.loading;
    notifyListeners();
    StockistListModel? list;
    try {
      Response response = await _dio.get(
        '${Api.users}/?mobileNo=$phone',
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        list = StockistListModel.fromMap(response.data);
        status = ApiStatus.success;
        notifyListeners();
        return list;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
      SnackBarService.instance
          .showSnackBarError('Error : This is not registered mobile number');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      SnackBarService.instance.showSnackBarError(e.toString());
      log(e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return list;
  }

  Future<WarrantyRequestList?> getWarrantyRequestListFromCrm(
      String stockistPhone) async {
    status = ApiStatus.loading;
    notifyListeners();
    WarrantyRequestList? list;
    try {
      Response response = await _dio.get(
        '${Api.getWarrantFromCrm}$stockistPhone',
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        list = WarrantyRequestList.fromMap(response.data);
        status = ApiStatus.success;
        notifyListeners();
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
      SnackBarService.instance
          .showSnackBarError('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      SnackBarService.instance.showSnackBarError(e.toString());
      log(e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return list;
  }

  Future<DealerListModel?> getAllDealers() async {
    status = ApiStatus.loading;
    notifyListeners();
    DealerListModel? list;
    try {
      Response response = await _dio.get(
        Api.dealers,
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        list = DealerListModel.fromMap(response.data);
        status = ApiStatus.success;
        notifyListeners();
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
      SnackBarService.instance
          .showSnackBarError('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      SnackBarService.instance.showSnackBarError(e.toString());
      log(e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return list;
  }

  Future<bool> allocateToDealer(List reqBody) async {
    status = ApiStatus.loading;
    notifyListeners();
    debugPrint(json.encode(reqBody));
    try {
      Response response = await _dio.post(
        Api.allocateToDealer,
        data: json.encode(reqBody),
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        status = ApiStatus.success;
        notifyListeners();
        return true;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
      SnackBarService.instance
          .showSnackBarError('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      SnackBarService.instance.showSnackBarError(e.toString());
      log(e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return false;
  }

  Future<WarrantyRequestList?> getWarrantyRequestListByStockist(
      int stockistId) async {
    status = ApiStatus.loading;
    notifyListeners();
    WarrantyRequestList? list;
    try {
      Response response = await _dio.get(
        '${Api.warrantyByStockist}$stockistId',
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        list = WarrantyRequestList.fromMap(response.data);
        status = ApiStatus.success;
        notifyListeners();
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
      SnackBarService.instance
          .showSnackBarError('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      SnackBarService.instance.showSnackBarError(e.toString());
      log(e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return list;
  }

  Future<bool> deleteWarrantyRequest(String id) async {
    status = ApiStatus.loading;
    notifyListeners();
    debugPrint(
      '${Api.deleteWarrantyRequest}$id',
    );
    try {
      Response response = await _dio.delete(
        '${Api.deleteWarrantyRequest}$id',
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      log(response.statusCode.toString());
      if (response.statusCode == 204) {
        status = ApiStatus.success;
        notifyListeners();
        return true;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
      SnackBarService.instance
          .showSnackBarError('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      SnackBarService.instance.showSnackBarError(e.toString());
      log(e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return false;
  }

  Future<bool> validateStockist(String phone, String code) async {
    status = ApiStatus.loading;
    notifyListeners();
    try {
      Response response = await _dio.get(
        '${Api.validateStockist}dealer_code=$code&mobile_number=$phone',
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        status = ApiStatus.success;
        notifyListeners();
        return true;
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
      SnackBarService.instance
          .showSnackBarError('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      SnackBarService.instance.showSnackBarError(e.toString());
      log(e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return false;
  }

  Future<WarrantyRequestList?> getWarrantyListFromCrm(UserModel user) async {
    status = ApiStatus.loading;
    notifyListeners();
    WarrantyRequestList? list;
    try {
      log('${Api.getWarrantyByStockistCode}dealer_code=${user.stockistCode}&mobile_number=${user.mobileNo}');
      Response response = await _dio.get(
        '${Api.getWarrantyByStockistCode}dealer_code=${user.stockistCode}&mobile_number=${user.mobileNo}',
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        list = WarrantyRequestList.fromMap(response.data);
        status = ApiStatus.success;
        notifyListeners();
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
      SnackBarService.instance
          .showSnackBarError('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      SnackBarService.instance.showSnackBarError(e.toString());
      log(e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return list;
  }

  Future<AllocatedList?> getAllocatedWarrantyList(int stockistId) async {
    status = ApiStatus.loading;
    notifyListeners();
    AllocatedList? list;
    try {
      Response response = await _dio.get(
        '${Api.allocateToDealer}stockist/$stockistId',
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        list = AllocatedList.fromMap(response.data);
        status = ApiStatus.success;
        notifyListeners();
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
      SnackBarService.instance
          .showSnackBarError('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      SnackBarService.instance.showSnackBarError(e.toString());
      log(e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return list;
  }

  Future<WarrantyModel?> getSerialDetailFromCrm(String serial) async {
    status = ApiStatus.loading;
    notifyListeners();
    WarrantyModel? model;
    try {
      Response response = await _dio.get(
        '${Api.deviceDetailFromCrm}$serial',
        options: Options(
          contentType: 'application/json',
          responseType: ResponseType.json,
        ),
      );
      if (response.statusCode == 200) {
        model = WarrantyModel.fromMap(response.data['data']);
        status = ApiStatus.success;
        notifyListeners();
      }
    } on DioException catch (e) {
      status = ApiStatus.failed;
      var resBody = e.response?.data ?? {};
      log(e.response?.data.toString() ?? e.response.toString());
      notifyListeners();
      // SnackBarService.instance
      //     .showSnackBarError('Error : ${resBody['message']}');
    } catch (e) {
      status = ApiStatus.failed;
      notifyListeners();
      // SnackBarService.instance.showSnackBarError(e.toString());
      log(e.toString());
    }
    status = ApiStatus.failed;
    notifyListeners();
    return model;
  }

  // Future<bool> sendAgreement(String phone, String userType, String id) async {
  //   status = ApiStatus.loading;
  //   notifyListeners();
  //   try {
  //     debugPrint(Api.buildAgreementUrl(phone, userType, id));
  //     Response response = await _dio.get(
  //       Api.buildAgreementUrl(phone, userType, id),
  //       options: Options(
  //         contentType: 'application/json',
  //         responseType: ResponseType.json,
  //       ),
  //     );
  //     if (response.statusCode == 200) {
  //       status = ApiStatus.success;
  //       notifyListeners();
  //       return true;
  //     }
  //   } on DioException catch (e) {
  //     status = ApiStatus.failed;
  //     var resBody = e.response?.data ?? {};
  //     log(e.response?.data.toString() ?? e.response.toString());
  //     notifyListeners();
  //     SnackBarService.instance
  //         .showSnackBarError('Error : ${resBody['message']}');
  //   } catch (e) {
  //     status = ApiStatus.failed;
  //     notifyListeners();
  //     SnackBarService.instance.showSnackBarError(e.toString());
  //     log(e.toString());
  //   }
  //   status = ApiStatus.failed;
  //   notifyListeners();
  //   return false;
  // }
}
