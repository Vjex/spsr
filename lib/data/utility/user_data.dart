import 'package:shared_preferences/shared_preferences.dart';
import 'package:spsr/data/models/user_sp_model.dart';
import 'package:spsr/data/models/user_sr_model.dart';

class User {
  //Log Out
  static logOutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Log Out
    await prefs.remove('isUserLogined');
    //Clear All he Locally Stored Darta

    //Removing All Data
    for (String key in prefs.getKeys()) {
      await prefs.remove(key);
    }
  }

  //Saving User Phone at login Page (After Phone Auth)
  static setUserAsLogined({SPModel? spUser, SRModel? srUser}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Save SP User Locally
    if (spUser != null) {
      await prefs.setBool('isUserLogined', true);
      await prefs.setString('userType', 'sp');
      await prefs.setInt('spidsp', spUser.spid);
      await prefs.setString('namesp', spUser.name);
      await prefs.setString('mobilesp', spUser.mobile);
      await prefs.setString('emailsp', spUser.email);
      await prefs.setString('addresssp', spUser.address);
      await prefs.setDouble('latsp', spUser.lat);
      await prefs.setDouble('lngsp', spUser.lng);
      await prefs.setString('createdDatesp', spUser.createdDate);
      await prefs.setString('updatedDatesp', spUser.updatedDate);
    } else if (srUser != null) {
      //Save SR User Locally.
      await prefs.setBool('isUserLogined', true);
      await prefs.setString('userType', 'sr');
      await prefs.setInt('sridsr', srUser.srid);
      await prefs.setString('namesr', srUser.name);
      await prefs.setString('mobilesr', srUser.mobile);
      await prefs.setString('emailsr', srUser.email);
      await prefs.setInt('spidsr', srUser.spid);
      await prefs.setString('addresssr', srUser.address);
      await prefs.setDouble('latsr', srUser.lat);
      await prefs.setDouble('lngsr', srUser.lng);
      await prefs.setInt('flagsr', srUser.flag);
      await prefs.setInt('custIdsr', srUser.custId);
      await prefs.setString('createdDatesr', srUser.createdDate);
      await prefs.setString('updatedDatesr', srUser.updatedDate);
      await prefs.setString('assignedDatesr', srUser.assignedDate);
    }
  }

//!Getters/////////////////////////////GETTTER//////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////

  static Future<Map<String, dynamic>> getEmployeeDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Get Employee Data saved in Shared Prefrences.

    bool _isUserLogined = prefs.getBool('isUserLogined') ?? false;
    String _userType = prefs.getString('userType') ?? '';

    Map<String, dynamic> detailObject = {
      'isUserLogined': _isUserLogined,
      'userType': _userType,
    };

    if (_isUserLogined && _userType.isNotEmpty && _userType == 'sp') {
      int spidsp = prefs.getInt('spidsp') ?? 0;
      String namesp = prefs.getString('namesp') ?? '';
      String mobilesp = prefs.getString('mobilesp') ?? '';
      String emailsp = prefs.getString('emailsp') ?? '';
      String addresssp = prefs.getString('addresssp') ?? '';
      double latsp = prefs.getDouble('latsp') ?? 0.0;
      double lngsp = prefs.getDouble('lngsp') ?? 0.0;
      String createdDatesp = prefs.getString('createdDatesp') ?? '';
      String updatedDatesp = prefs.getString('updatedDatesp') ?? '';

      detailObject = {
        'isUserLogined': _isUserLogined,
        'userType': _userType,
        'spid': spidsp,
        'name': namesp,
        'mobile': mobilesp,
        'email': emailsp,
        'address': addresssp,
        'lat': latsp,
        'lng': lngsp,
        'createdDate': createdDatesp,
        'updatedDate': updatedDatesp,
      };
    } else if (_isUserLogined && _userType.isNotEmpty && _userType == 'sr') {
      int sridsr = prefs.getInt('sridsr') ?? 0;
      String namesr = prefs.getString('namesr') ?? '';
      String mobilesr = prefs.getString('mobilesr') ?? '';
      String emailsr = prefs.getString('emailsr') ?? '';
      int spidsr = prefs.getInt('spidsr') ?? 0;
      String addresssr = prefs.getString('addresssr') ?? '';
      double latsr = prefs.getDouble('latsr') ?? 0.0;
      double lngsr = prefs.getDouble('lngsr') ?? 0.0;
      int flagsr = prefs.getInt('flagsr') ?? 0;
      int custIdsr = prefs.getInt('custIdsr') ?? 0;
      String createdDatesr = prefs.getString('createdDatesr') ?? '';
      String updatedDatesr = prefs.getString('updatedDatesr') ?? '';
      String assignedDatesr = prefs.getString('assignedDatesr') ?? '';

      detailObject = {
        'isUserLogined': _isUserLogined,
        'userType': _userType,
        'srid': sridsr,
        'name': namesr,
        'mobile': mobilesr,
        'email': emailsr,
        'address': addresssr,
        'spid': spidsr,
        'lat': latsr,
        'lng': lngsr,
        'flag': flagsr,
        'custId': custIdsr,
        'createdDate': createdDatesr,
        'updatedDate': updatedDatesr,
        'assignedDate': assignedDatesr,
      };
    }

    return detailObject;
  }
}
