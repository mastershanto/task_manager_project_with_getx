import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';



import '../../presentation/state_holder/authentication_controller.dart';
import '../models/network_response.dart';


class NetworkCaller {
  static Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body, bool isLogin = false}) async {
    try {
      final Response response =
      await post(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-type': 'application/json',
        'token': AuthenticationController.token.toString(),
      });
      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: 200,
          jsonResponse: jsonDecode(response.body),
        );
      } else if (response.statusCode == 401) {
        if (isLogin == false) {
          AuthenticationController.backToLogin();
        }
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      }
    } catch (e) {
      log(e.toString());
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }

  static Future<NetworkResponse> getRequest(String url) async {
    try {
      final Response response = await get(Uri.parse(url), headers: {
        'Content-type': 'application/json',
        'token': AuthenticationController.token.toString(),
      });
      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: 200,
          jsonResponse: jsonDecode(response.body),
        );
      } else if (response.statusCode == 401) {
        AuthenticationController.backToLogin();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          jsonResponse: jsonDecode(response.body),
        );
      }
    } catch (e) {
      log(e.toString());
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }
}
