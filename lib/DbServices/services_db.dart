import'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'dept_db.dart';

class Services
{
  static const FETCH ='https://studentappprototype.azurewebsites.net/dept/getall';
  static const ADD ='https://studentappprototype.azurewebsites.net/dept/insert';
  static const UPDATE ='https://studentappprototype.azurewebsites.net/dept/update';
  static const DELETE ='https://studentappprototype.azurewebsites.net/dept/delete';
  static const LOGIN ='https://studentappprototype.azurewebsites.net/dept/login';

  //fetching the table
  static Future<List<Department>> getDepartments(int clglink) async{
    try{
      var map=Map<String,dynamic>();
      print("\n\n\n\n\n");
      map['clglink']=clglink.toString();
      print(map);
      print("\n\n\n\n\n");
      final response=await http.post(Uri.parse(FETCH),body: map);
      // final response=await http.get(Uri.parse(FETCH));
      // print("\n\n\n\n\n response body");
      // print('get table response:${response.body}');
      // print("\n\n\n\n\n");
      EasyLoading.show(status: 'loading...');
      if(response.statusCode==200){
        print("status 200");
        List<Department> list=parseResponse(response.body);
        EasyLoading.showSuccess('Success!');
        EasyLoading.dismiss();
        // print("Services");
        // list.forEach((element) {
        //   print(element.name);
        // });
        // print(list);
        return list;
      }
      else {
        return List<Department>.empty();
      }
    }catch(e) {
      return List<Department>.empty(); //empty list
    }
  }
  static List<Department> parseResponse(String responseBody){
    Map<String, dynamic> response = jsonDecode(responseBody);
    final parsed=response["data"];
    List<Department> depts=[];
    parsed.forEach((item){
      var college_link=item["college_link"];
      var id=item["dept_id"];
      var name=item["dept_name"] as String?;
      var helpno=item["office_help"] as String?;
      var userid=item["dept_admin_username"] as String?;
      var password=item["dept_admin_password"] as String?;
      Department d=new Department(college_link,id,name,helpno,userid,password);
      depts.add(d);
    });
    return depts;
  }


  //adding an entry to the table
  static Future<String?> addDepartment(int clg_id,String name,String offno,String userid,String pass) async{
    try{
      var map=Map<String,dynamic>();
      map['clglink']=clg_id.toString();
      map['deptname']=name;
      map['offno']=offno;
      map['uname']=userid;
      map['pass']=pass;
      final response=await http.post(Uri.parse(ADD),body: map);
      print('add department response:${response.body}');
      EasyLoading.show(status: 'adding department');
      if(response.statusCode==200){
        EasyLoading.showSuccess('Success!');
        EasyLoading.dismiss();
        Map<String, dynamic> status = jsonDecode(response.body);
        return status["result"];
      }
      else {
        EasyLoading.showError('Failed');
        EasyLoading.dismiss();
        return "error";
      }

    }catch(e) {
      return e.toString();
    }
  }

  //updating an existing entry in the table
  static Future<String?> updateDepartment(String helpno,String pass,int deptid) async{
    try{
      var map=Map<String,dynamic>();
      map['deptid']=deptid.toString();
      map['password']=pass;
      map['helpno']=helpno;
      //print(map.toString());
      final response=await http.post(Uri.parse(UPDATE),body: map);
      //print('update college response:${response.body}');
      EasyLoading.show(status: 'updating department');
      if(response.statusCode==200){
        EasyLoading.showSuccess('Success!');
        EasyLoading.dismiss();
        // return response.body;
        Map<String, dynamic> status = jsonDecode(response.body);
        return status["result"];
      }
      else {
        EasyLoading.showError('Failed');
        EasyLoading.dismiss();
        return "errormain";
      }
    }catch(e) {
      return e.toString();
    }
  }

  static Future<String?> deleteDepartment(int? id) async{
    try{
      var map=Map<String,dynamic>();
      map['id']=id.toString();
      final response=await http.post(Uri.parse(DELETE),body: map);//check this error
      print('delete department response:${response.body}');
      EasyLoading.show(status: 'deleting department');
      if(response.statusCode==200){
        EasyLoading.showSuccess('Success!');
        EasyLoading.dismiss();
        Map<String, dynamic> status = jsonDecode(response.body);
        return status["result"];
      }
      else {
        return "error";
      }
    }catch(e) {
      EasyLoading.showError('Failed');
      EasyLoading.dismiss();
      return e.toString();
    }
  }

  static Future<int> checkLogin(String username,String password) async{
    try{
      var map=Map<String,dynamic>();
      map['userid']=username;
      map['password']=password;
      final response=await http.post(Uri.parse(LOGIN),body: map);
      //print('get table response:${response.body}');
      EasyLoading.show(status: 'logging in');
      if(response.statusCode==200){
        EasyLoading.dismiss();
        print("login response:");
        print(response.body);
        Map<String, dynamic> status = jsonDecode(response.body);
        // print(status["result"]);
        // return response.body;
        return status["result"][0]["dept_id"];
      }
      else {
        EasyLoading.dismiss();
        return -1;
      }
    }catch(e) {
      return -2; //empty list
    }
  }
}
