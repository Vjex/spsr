import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

class User {
  //Log Out
  static logOutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Log Out
    await prefs.remove('isUserLogined');
    //Clear All he Lovcally Stored Darta
    // await prefs.clear();

    //  prefs.getKeys();
    //Removing All Data
    for (String key in prefs.getKeys()) {
      //Saving EmpId and PWd Login For Later use After LogOUt
      if (key == 'empIdLogin' ||
          key == 'pwdLogin' ||
          key == 'LastBioDateTime' ||
          key == 'NextBioString' ||
          key == 'isInstalledDetailsInserted' ||
          key == 'insertedVersion' ||
          key == 'PunchEmpId') {
        continue;
      } else {
        await prefs.remove(key);
      }
    }
  }

  //Save Employee and Passwor For Login.
  static saveEmpAndPwdForLogin(String empId, String pwd) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('empIdLogin', empId.toUpperCase());
    await prefs.setString('pwdLogin', pwd);
  }

  //Saving User Phone at login Page (After Phone Auth)
  static setUserAsLogined(String empId, String designation, String photoUrl,
      String empName, dynamic employeeDetailsObject) async {
    // print(employeeDetailsObject.toString());

    //Getting Employe Details From The Objet passed to Save in Shared Prefrence.
    String empINTID = employeeDetailsObject['INTID'] as String;
    String empDOB = employeeDetailsObject['DOB'] as String;
    String empDOD = employeeDetailsObject['DOD'] as String;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isUserLogined', true);
    if (empId != null) await prefs.setString('EmployeeID', empId.toUpperCase());
    // await prefs.setString('EmployeeID', 'CE021614718');
    if (designation != null) await prefs.setString('Designation', designation);
    if (photoUrl != null) await prefs.setString('PhotoUrl', photoUrl);
    if (empName != null) await prefs.setString('empName', empName);

    if (empINTID != null) await prefs.setString('INTID', empINTID);
    if (empDOB != null) await prefs.setString('DOB', empDOB);
    if (empDOD != null) await prefs.setString('DOD', empDOD);
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////ALL GET METHODTS FOR THE SAVED DATA ////////////////////////////////////////////////////

  //Get Employee and Passwor For Login.
  static Future<Map<String, String>> getEmpAndPwdForLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String empId = prefs.getString('empIdLogin') != null
        ? prefs.getString('empIdLogin') as String
        : '';
    String pwd = prefs.getString('pwdLogin') != null
        ? prefs.getString('pwdLogin') as String
        : '';

    var data = {
      'empIdLogin': empId,
      'pwdLogin': pwd,
    };

    return data;
  }

  static Future<Map<String, String>> getEmployeeDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Get Employee ID saved in Shared Prefrences.
    String _employeeId = prefs.getString('EmployeeID') != null
        ? prefs.getString('EmployeeID') as String
        : '';
    String _employeeDesignation = prefs.getString('Designation') != null
        ? prefs.getString('Designation') as String
        : '';
    String _employeePhoto = prefs.getString('PhotoUrl') != null
        ? prefs.getString('PhotoUrl') as String
        : '';
    String _employeeName = prefs.getString('empName') != null
        ? prefs.getString('empName') as String
        : '';

    Map<String, String> detailObject = {
      'EmployeeID': _employeeId,
      'Designation': _employeeDesignation,
      'PhotoUrl': _employeePhoto,
      'EmpName': _employeeName,
    };

    return detailObject;
  }
}
