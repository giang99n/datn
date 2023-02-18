import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/constants.dart';
import '../models/change_password_res.dart';
import '../models/devices_res.dart';
import '../models/login_res.dart';
import '../models/sensors_res.dart';
import '../models/signup_res.dart';
import '../models/user_res.dart';
import 'dio_client.dart';

class Api {
  RestClient restClient = RestClient(Dio());

  Future<LoginResponse?> login(String email, String password) async {
    Response response;
    try {
      response = await restClient
          .post('api/auth/login', data: {'email': email, 'password': password});
      print(response);
      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
      } else if (response.statusCode == 401) {
        print(response.data.toString());
        return LoginResponse.fromJson(response.data);
      } else {
        print('There is some problem status code not 200');
        return null;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data.toString());
        return null;
      } else {
        print(e.message);
        return null;

      }
    }
    return null;
  }

  Future<ChangePasswordResponse?> changePassword(
      String email, String oldPassword, String newPassword) async {
    Response response;
    try {
      response = await restClient.post('api/auth/changePassword', data: {
        'email': email,
        'oldPassword': oldPassword,
        'newPassword': newPassword
      });
      if (response.statusCode == 200) {
        return ChangePasswordResponse.fromJson(response.data);
      } else {
        print('There is some problem status code not 200');
        return ChangePasswordResponse.fromJson(response.data);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data.toString());
      } else {
        print(e.message);
      }
    }
    return null;
  }

  Future<UserResponse?> getUser(String token, String userId) async {
    Dio dio = Dio();
    // dio.options.headers["Authorization"] = "Bearer $token";
    dio.interceptors.add(PrettyDioLogger());
    Response response;
    try {
      response = await dio.get('${AppConstants.baseUrl}api/user',
          queryParameters: {'id': userId});
      if (response.statusCode == 200) {
        return UserResponse.fromJson(response.data);
      } else {
        print('There is some problem status code not 200');
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

  Future<SignupResponse?> Signup(String name, String email, String password,
      String job, String phoneNumber) async {
    Response response;
    try {
      response = await restClient.post('api/user/create', data: {
        "name": name,
        "username": email,
        "password": password,
        "job": job,
        "phone": phoneNumber,
        "verify": true,
        "home": {
          "address": "Tam Giang, Yên Phong, Bắc Ninh",
          "type": "Point",
          "coordinates": [108.215028, 16.053509]
        },
        "language": "en"
      });
      if (response.statusCode == 200) {
        return SignupResponse.fromJson(response.data);
      } else {
        print('There is some problem status code not 200');
      }
    } on DioError catch (e) {
      // BaseResponse br = BaseResponse.fromJson(e.response.data);
      return SignupResponse.fromJson(e.response.data);
      // ErrorHandle eh =  ErrorHandle(dioErrorType: e.type, baseResponse: sr );
      // eh.defaultError();
    }
    return null;
  }

  Future<DeviceResponse?> getDevice(String token, String email) async {
    Dio dio = Dio();
    dio.options.headers["Authorization"] = "Bearer $token";
    dio.interceptors.add(PrettyDioLogger());
    Response response;
    try {
      response = await dio.get('${AppConstants.baseUrl}api/device/listDevice',
          queryParameters: {'email': email});
      if (response.statusCode == 200) {
        return DeviceResponse.fromJson(response.data);
      } else {
        print('There is some problem status code not 200');
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }

  Future<SensorsResponse?> getSensors(String dateBegin, String dateEnd) async {
    Dio dio = Dio();
    //dio.options.headers["Authorization"] = "Bearer $token";
    dio.interceptors.add(PrettyDioLogger());
    Response response;
    try {
      response = await dio.get('http://192.168.0.102:4000/api/sensor',
          queryParameters: {'begin': dateBegin, 'end': dateEnd});
      if (response.statusCode == 200) {
        print(response.data);
        return SensorsResponse.fromJson(response.data);
      } else {
        print('There is some problem status code not 200');
      }
    } on Exception catch (e) {
      print(e);
    }
    return null;
  }
}
