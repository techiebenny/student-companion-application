class Department{
  int? id;
  String? name;
  String? description;
  String? admin;
  String? password;
  int? subject_count;

  Department({this.id,this.name,this.description,this.admin,this.password,this.subject_count});

  factory Department.fromJson(Map<String,dynamic> json){
    return Department(
      id:int.parse(json['id']),
      name:json['name'] as String?,
      description:json['description'] as String?,
      admin:json['admin'] as String?,
      password:json['password'] as String?,
      subject_count:int.parse(json['subject_count'])
    );
  }

  @override
  String toString() {
    print(id);
    print(name);
    print(admin);
    print(password);
    return super.toString();
  }
}