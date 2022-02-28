import'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'class_db.dart';

class Services
{
  static const FETCH ='https://studentappprototype.azurewebsites.net/dept/section/getall';
  static const ADD ='https://studentappprototype.azurewebsites.net/dept/section/insert';
  static const UPDATE ='https://studentappprototype.azurewebsites.net/dept/section/update';
  static const DELETE ='https://studentappprototype.azurewebsites.net/dept/section/delete';
  // static const LOGIN ='https://studentappprototype.azurewebsites.net/section/login';

  //fetching the table
  static Future<List<Student_class>> getSections(int deptlink) async{
    try{
      var map=Map<String,dynamic>();
      print("\n\n\n\n\n");
      map['deptlink']=deptlink.toString();
      print(map);
      print("\n\n\n\n\n");
      final response=await http.post(Uri.parse(FETCH),body: map);
      // final response=await http.get(Uri.parse(FETCH));
      print("\n\n\n\n\n response body");
      print('get table response:${response.body}');
      print("\n\n\n\n\n");
      EasyLoading.show(status: 'loading...');
      if(response.statusCode==200){
        print("status 200");
        List<Student_class> list=parseResponse(response.body);
        EasyLoading.showSuccess('Success!');
        EasyLoading.dismiss();
        // print("Services");
        // list.forEach((element) {
        //   print(element.name);
        // });
        return list;
      }
      else {
        return List<Student_class>.empty();
      }
    }catch(e) {
      return List<Student_class>.empty(); //empty list
    }
  }
  static List<Student_class> parseResponse(String responseBody){
    Map<String, dynamic> response = jsonDecode(responseBody);
    final parsed=response["data"];
    print('\n\n\n\n');
    print(parsed);
    print('\n\n\nworking');
    List<Student_class> classes=[];
    parsed.forEach((item){
      int? dept_link=1;
      int? section_id=item["section_id"];
      var section_name=item["section_name"] as String?;
      int section_batch_join=item["section_batch_join"];
      String? section_batch_join_string=section_batch_join.toString();
      var section_classcode=item["section_classcode"] as String?;
      Student_class c=new Student_class(dept_link,section_id,section_name,section_batch_join_string,section_classcode);
      print(c);
      classes.add(c);
    });
    return classes;
  }


  //adding an entry to the table
  static Future<String?> addSection(int dept_link,String section_name,String section_batch_join,String section_code) async{
    try{
      var map=Map<String,dynamic>();
      map['dept_link']=dept_link.toString();
      map['section_name']=section_name;
      map['section_batch_join']=section_batch_join;
      map['section_code']=section_code;
      final response=await http.post(Uri.parse(ADD),body: map);
      print('add class-section response:${response.body}');
      EasyLoading.show(status: 'adding section');
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
  static Future<String?> updateSection(int section_id,String section_name,String section_batch_join) async{
    try{
      var map=Map<String,dynamic>();
      map['section_id']=section_id.toString();
      map['section_name']=section_name;
      map['year']=section_batch_join;
      //print(map.toString());
      final response=await http.post(Uri.parse(UPDATE),body: map);
      //print('update college response:${response.body}');
      EasyLoading.show(status: 'updating section');
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

  static Future<String?> deleteSection(int? id) async{
    try{
      var map=Map<String,dynamic>();
      map['id']=id.toString();
      final response=await http.post(Uri.parse(DELETE),body: map);//check this error
      print('delete section:${response.body}');
      EasyLoading.show(status: 'deleting section');
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

}
