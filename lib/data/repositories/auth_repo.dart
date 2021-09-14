import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '/constants/constant_strings.dart';
import '/data/models/user_sp_model.dart';
import '/data/models/user_sr_model.dart';
import '/data/dataproviders/api_service.dart';

class AuthRepository {
  //Login SP
  static APIService<SPModel> loginSp(String loginId, String refrance) {
    var bodyP = {
      'appkey': 'login',
      'LoginId': loginId,
      'refrance': refrance,
      'userT': 'sp'
    };
    return APIService(
        // url: Uri.http(baseAPIEcommerce, endpoint),
        url: Uri.parse(ConstantString.baseUrlApi + '/login_sp_sr.php'),
        body: bodyP,
        // url: url,
        parse: (response) {
          final parsed = json.decode(response.body);

          if (parsed['status'] == 1) {
            var dd = parsed['data'];
            var spd = SPModel.fromMap(dd);

            return spd;
          } else {
            throw Exception(parsed['msg'] as String);
          }

          // var productList = dataJson.responsedata as List;
          // List<ProductModel> products = productList.map((i) => ProductModel.fromJSON(i)).toList();

          // return products;
        });
  }

  //Login SR
  static APIService<SRModel> loginSr(String loginId, String refrance) {
    var bodyP = {
      'appkey': 'login',
      'LoginId': loginId,
      'refrance': refrance,
      'userT': 'sr'
    };
    return APIService(
      // url: Uri.http(baseAPIEcommerce, endpoint),
      url: Uri.parse(ConstantString.baseUrlApi + '/login_sp_sr.php'),
      body: bodyP,
      // url: url,
      parse: (response) {
        final parsed = json.decode(response.body);
        if (parsed['status'] == 1) {
          return SRModel.fromMap(parsed['data']);
        } else {
          throw Exception(parsed['msg'] as String);
        }
      },
    );
  }

  //SignUp SP
  static APIService<dynamic> signUpSP(String name, String email, String mobile,
      String pass, LatLng position, Placemark address) {
    var bodyP = {
      'appkey': 'signUp',
      'name': name,
      'mobile': email,
      'email': pass,
      'address': address.name,
      'password': pass,
      'lat': position.latitude,
      'long': position.longitude,
      'userT': 'sp'
    };
    return APIService(
      // url: Uri.http(baseAPIEcommerce, endpoint),
      url: Uri.parse(ConstantString.baseUrlApi + '/signup_sp_sr.php'),
      body: bodyP,
      // url: url,
      parse: (response) {
        final parsed = json.decode(response.body);
        if (parsed['status'] == 1) {
          return parsed;
        } else {
          throw Exception(parsed['msg'] as String);
        }
      },
    );
  }
}
