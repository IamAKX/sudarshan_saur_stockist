import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:saur_stockist/model/model_list/stockist_list_model.dart';

import '../main.dart';
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

  ApiProvider() {
    _dio = Dio();
  }

  Future<bool> createUser(UserModel user) async {
    status = ApiStatus.loading;
    notifyListeners();
    try {
      Map<String, dynamic> reqBody = {
        "stockistName": user.stockistName,
        "password": user.password,
        "mobileNo": user.mobileNo,
        "status": user.status,
        "email": user.email,
        "address": user.address!.toMap(),
        "image": user.image,
        "lastLogin": user.lastLogin,
        "businessName": user.businessName,
        "businessAddress": user.businessAddress,
        "gstNumber": user.gstNumber
      };
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

  Future<bool> login(String email, String password) async {
    status = ApiStatus.loading;
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
}
