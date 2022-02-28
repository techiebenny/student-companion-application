class College{
  int? id;
  String? name;
  String? about;
  // String logo;//no parse for bool hence taking String
  String? bigpicture;
  String? userid;
  String? password;

  College(id,name,about,userid,password,bigpicture){
    this.id=id;
    this.name=name;
    this.about=about;
    this.userid=userid;
    this.password=password;
    this.bigpicture=bigpicture;
  }

// factory College.fromJson(Map<String,dynamic> json){
//   return College(
//       id:int.parse(json['id']),
//       name:json['name'] as String,
//     about:json['about'] as String,
//     userid:json['userid'] as String,
//     password:json['password'] as String,
//   );
// }

// @override
//   String toString() {
//     print(id);
//     print(name);
//     print(userid);
//     print(password);
//     return super.toString();
//   }
}