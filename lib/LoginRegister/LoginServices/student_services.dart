import'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Tasks.dart';

class Services
{
  static const ADD ='https://studentappprototype.azurewebsites.net/student/insert';
  static const ADD_TASK ='https://studentappprototype.azurewebsites.net/student/tasks/insert';
  static const LOGIN ='https://studentappprototype.azurewebsites.net/student/login';
  static const GET_TASK ='https://studentappprototype.azurewebsites.net/student/tasks/get';

  //adding an entry to the table
  static Future<String?> addStudent(String student_email,String student_password,String student_name,String id,String class_code) async{
    try{
      var map=Map<String,dynamic>();
      map['email']=student_email;
      map['password']=student_password;
      map['name']=student_name;
      map['usn']=id;
      map['classcode']=class_code;
      // print(map.toString());
      final response=await http.post(Uri.parse(ADD),body: map);
      print('add student response:${response.body}');
      // EasyLoading.show(status: 'adding college');
      if(response.statusCode==200){
        // EasyLoading.showSuccess('Success!');
        // EasyLoading.dismiss();
        Map<String, dynamic> status = jsonDecode(response.body);
        print(status["result"]);
        return status["result"];
      }
      else {
        // EasyLoading.showError('Failed');
        // EasyLoading.dismiss();
        return "error";
      }

    }catch(e) {
      return e.toString();
    }
  }

  static Future<String?> checkLogin(String username,String password) async{
    try{
      var map=Map<String,dynamic>();
      map['username']=username;
      map['password']=password;
      final response=await http.post(Uri.parse(LOGIN),body: map);
      //print('get table response:${response.body}');
      // EasyLoading.show(status: 'logging in');
      if(response.statusCode==200){
        // EasyLoading.dismiss();
        print("login response:");
        // print(response.body);

        Map<String, dynamic> status = jsonDecode(response.body);
        // print(status["result"][0]["id"]);
        // print(status["result"][0]["id"]==null);
        // return response.body;
        if(status["result"].length==0){
          return "-3";
        }else{
          SharedPreferences prefs = await SharedPreferences.getInstance();
          print(status["result"][0]);
          if(status["result"][0]["class_link"]!=null) {
            // print(status["result"][0]["class_link"]);
            prefs.setInt("class_link",status["result"][0]["class_link"]);
            prefs.setString("student_id",status["result"][0]["id"]);
            print("shared prefs set");
          }
          // print(status["result"][0]["id"]);
          return status["result"][0]["id"];
        }

      }
      else {
        // EasyLoading.dismiss();
        return "-1";
      }
    }catch(e) {
      print(e);
      return "-2"; //empty list
    }
  }

  static Future<String?> addTask(String task_name,String task_description,String date_of_submission,String class_link) async{
    try{
      //tskname,tskdescription,date,section_link
      var map=Map<String,dynamic>();
      map['tskname']=task_name;
      map['tskdescription']=task_description;
      map['date']=date_of_submission;
      map['section_link']=class_link;
      // print(map.toString());
      final response=await http.post(Uri.parse(ADD_TASK),body: map);
      print('add task response:${response.body}');
      // EasyLoading.show(status: 'adding college');
      if(response.statusCode==200){
        // EasyLoading.showSuccess('Success!');
        // EasyLoading.dismiss();
        Map<String, dynamic> status = jsonDecode(response.body);
        print(status["result"]);
        return status["result"];
      }
      else {
        // EasyLoading.showError('Failed');
        // EasyLoading.dismiss();
        return "error";
      }

    }catch(e) {
      return e.toString();
    }
  }


  static Future<List<Tasks>> getTasks(class_link) async{
    try{
      // print("Running1");
      var map=Map<String,dynamic>();
      print("\n\n\n\n\n map");
      map['class_link']=class_link.toString();
      print(map);
      print("\n\n\n\n\n hello");
      final response=await http.post(Uri.parse(GET_TASK),body: map);
      print("\n\n\n\n\n response body");
      print('get table response:${response.body}');
      // print(response.statusCode);
      if(response.statusCode==200){
        print("status 200");
        List<Tasks> list=parseResponse(response.body);
        return list;
      }
      else {
        return List<Tasks>.empty();
      }
    }catch(e) {
      print(e.toString());
      return List<Tasks>.empty(); //empty list
    }
  }
  static List<Tasks> parseResponse(String responseBody){
    Map<String, dynamic> response = jsonDecode(responseBody);
    final parsed=response["result"];
    print(parsed);
    List<Tasks> tasks=[];
    parsed.forEach((item){
      // print("1");
      var id=item["id"] as int?;
      // print("2");
      var name=item["name"] as String?;
      // print("3");
      var description=item["description"] as String?;
      // print("4");
      Tasks c=new Tasks(id,name,description);
      // print("5");
      tasks.add(c);
    });
    return tasks;
  }




}
