import'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'college_db.dart';

class Services
{
  static const FETCH ='https://studentappprototype.azurewebsites.net/getall';
  static const ADD ='https://studentappprototype.azurewebsites.net/insert';
  static const UPDATE ='https://studentappprototype.azurewebsites.net/update';
  static const DELETE ='https://studentappprototype.azurewebsites.net/delete';
  static const LOGIN ='https://studentappprototype.azurewebsites.net/login';

  static const _CREATE_TABLE_ACTION ='CREATE_TABLE';
  static const _GET_ALL_ACTION ='GET_ALL';
  static const _ADD_COLLEGE_ACTION ='ADD_COLLEGE';
  static const _UPDATE_COLLEGE_ACTION ='UPDATE_COLLEGE';
  static const _DELETE_COLLEGE_ACTION ='DELETE_COLLEGE';
  static const _GET_LOGIN_ACTION ='GET_LOGIN';
  static const _SIGNUP_ACTION ='SIGNUP';


  //creating table
  // static Future<String> createTable() async{
  //   try{
  //     var map=Map<String,dynamic>();
  //     map['action']=_CREATE_TABLE_ACTION;
  //     final response=await http.post(Uri.parse(ROOT),body: map);//check this error
  //     print('Create table response:${response.body}');
  //     if(response.statusCode==200) return response.body;
  //     else return "error";
  //   }
  //   catch(e)
  //   {
  //     return "error";
  //   }
  // }

  //fetching the table
  static Future<List<College>> getCollege() async{
    try{
      var map=Map<String,dynamic>();
      // map['action']=_GET_ALL_ACTION;    not required in node
      print("\n\n\n\n\n");
      print(map);
      print("\n\n\n\n\n");
      // final response=await http.post(Uri.parse(FETCH),body: map);
      final response=await http.get(Uri.parse(FETCH));
      // print("\n\n\n\n\n response body");
      // print('get table response:${response.body}');
      // print("\n\n\n\n\n");
      EasyLoading.show(status: 'loading...');
      if(response.statusCode==200){
        print("status 200");
        List<College> list=parseResponse(response.body);
        EasyLoading.showSuccess('Success!');
        EasyLoading.dismiss();
        // print("Services");
        // list.forEach((element) {
        //   print(element.name);
        // });
        return list;
      }
      else {
        return List<College>.empty();
      }
    }catch(e) {
      return List<College>.empty(); //empty list
    }
  }
  static List<College> parseResponse(String responseBody){
    Map<String, dynamic> response = jsonDecode(responseBody);
    final parsed=response["data"];
    List<College> colleges=[];
    parsed.forEach((item){
      var id=item["id"];
      var name=item["name"] as String?;
      var about=item["about"] as String?;
      var userid=item["username"] as String?;
      var password=item["password"] as String?;
      var bigpicture="null";
      College c=new College(id ,name,about ,userid ,password,bigpicture);
      colleges.add(c);
    });
    return colleges;
  }


  //adding an entry to the table
  static Future<String?> addCollege(String name,String userid,String bio) async{
    try{
      var map=Map<String,dynamic>();
      // map['action']=_ADD_COLLEGE_ACTION;
      map['name']=name;
      map['about']=bio;
      map['userid']=userid;
      map['password']="testpassword";//TODO:generate at php later
      // print(map.toString());
      final response=await http.post(Uri.parse(ADD),body: map);
      print('add college response:${response.body}');
      EasyLoading.show(status: 'adding college');
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
  static Future<String?> updateCollege(int? id,String name,String about,String password,String userid,String bigpicture) async{
    try{
      var map=Map<String,dynamic>();
      map['name']=name;
      map['about']=about;
      map['id']=id.toString();//pass as string even flutter throws an error for int cast
      map['password']=password;
      map['userid']=userid;
      map['bigpicture']=bigpicture;
      //print(map.toString());
      final response=await http.post(Uri.parse(UPDATE),body: map);
      //print('update college response:${response.body}');
      EasyLoading.show(status: 'updating college');
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

  //deleting an entry in the table
  // static Future<String> deleteCollege(int id) async{
  //   try{
  //     var map=Map<String,dynamic>();
  //     map['action']=_DELETE_COLLEGE_ACTION;
  //     map['id']=id.toString();
  //     final response=await http.post(Uri.parse(ROOT),body: map);//check this error
  //     print('delete college response:${response.body}');
  //     EasyLoading.show(status: 'deleting college');
  //     if(response.statusCode==200){
  //       EasyLoading.showSuccess('Success!');
  //       EasyLoading.dismiss();
  //       return response.body;
  //     }
  //     else {
  //       return "error";
  //     }
  //   }catch(e) {
  //     EasyLoading.showError('Failed');
  //     EasyLoading.dismiss();
  //     return e.toString();
  //   }
  // }

  static Future<String?> deleteCollege(int? id) async{
    try{
      var map=Map<String,dynamic>();
      map['id']=id.toString();
      final response=await http.post(Uri.parse(DELETE),body: map);//check this error
      print('delete college response:${response.body}');
      EasyLoading.show(status: 'deleting college');
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

  //function for checking login on serverside
  // static Future<String> checkLogin(String username,String password) async{
  //   try{
  //     var map=Map<String,dynamic>();
  //     map['action']=_GET_LOGIN_ACTION;
  //     map['userid']=username;
  //     map['password']=password;
  //     final response=await http.post(Uri.parse(ROOT),body: map);
  //     //print('get table response:${response.body}');
  //     EasyLoading.show(status: 'logging in');
  //     if(response.statusCode==200){
  //       EasyLoading.dismiss();
  //       print("login response:");
  //       print(response.body);
  //       return response.body;
  //     }
  //     else {
  //       EasyLoading.dismiss();
  //       return "error";
  //     }
  //   }catch(e) {
  //     return "exception"; //empty list
  //   }
  // }

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
        // print(response.body);

        Map<String, dynamic> status = jsonDecode(response.body);
        // print(status["result"][0]["college_id"]);
        // return response.body;
        return status["result"][0]["college_id"];
      }
      else {
        EasyLoading.dismiss();
        return -1;
      }
    }catch(e) {
      print(e);
      return -2; //empty list
    }
  }
}
