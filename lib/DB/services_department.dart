import'dart:convert';
import 'package:http/http.dart' as http;
import 'department_db.dart';
import 'college_db.dart';

class Services {
  static const ROOT = 'https://teststudentapp.000webhostapp.com/department_data.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_DEPARTMENT_ACTION = 'ADD_DEPARTMENT';
  static const _UPDATE_DEPARTMENT_ACTION = 'UPDATE_DEPARTMENT';
  static const _DELETE_DEPARTMENT_ACTION = 'DELETE_DEPARTMENT';

  //creating table
  static Future<String> createTable() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(
          Uri.parse(ROOT), body: map); //check this error
      print('Create table response:${response.body}');
      if (response.statusCode == 200)
        return response.body;
      else
        return "error";
    }
    catch (e) {
      return "error";
    }
  }

  //fetching the table
  static Future<List<Department>?> getDepartments() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(Uri.parse(ROOT), body: map); //check this error
      print('get table response:${response.body}');
      if (response.statusCode == 200) {
        List<Department>? list = parseResponse(response.body);
        return list;
      }
      else {
        return List<Department>.empty();
      }
    } catch (e) {
      print(e.toString());
      return List<Department>.empty(); //empty list
    }
  }

  static List<Department>? parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Department>((json) => Department.fromJson(json)).toList();
  }


  //adding an entry to the table
  static Future<String> addDepartment(String name, String admin,
      String password) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_DEPARTMENT_ACTION;
      map['name'] = name;
      map['description'] = 'xyz';
      map['admin'] = admin;
      map['password'] = password;
      map['subject_count'] = '0'; //int values are also always passed as strings
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('add college response:${response.body}');
      if (response.statusCode == 200) {
        return response.body;
      }
      else {
        return "error";
      }
    } catch (e) {
      return e.toString();
    }
  }

  //updating an existing entry in the table
  static Future<String> updateDepartment(int id, String name, String description,
      String admin, String password, int count) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_DEPARTMENT_ACTION;
      map['name'] = name;
      map['description'] = description;
      map['id'] = id.toString(); //pass as string even flutter throws an error for int cast
      map['password'] = password;
      map['admin'] = admin;
      map['count'] = count.toString();
      //print(map.toString());
      final response = await http.post(Uri.parse(ROOT), body: map);
      print('update department response:${response.body}');
      if (response.statusCode == 200) {
        return response.body;
      }
      else {
        return "errormain";
      }
    } catch (e) {
      return e.toString();
    }
  }

  //deleting an entry in the table
  static Future<String> deleteDepartment(int id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_DEPARTMENT_ACTION;
      map['id'] = id.toString();
      final response = await http.post(
          Uri.parse(ROOT), body: map); //check this error
      print('delete department response:${response.body}');
      if (response.statusCode == 200) {
        return response.body;
      }
      else {
        return "error";
      }
    } catch (e) {
      return e.toString();
    }
  }

}