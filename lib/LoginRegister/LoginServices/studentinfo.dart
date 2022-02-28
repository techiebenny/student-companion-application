class Student {
  String? id;
  String? student_name;
  String? student_email;

  // String logo;//no parse for bool hence taking String
  String? student_password;
  String? student_phone_number;
  int? auth_level;
  int? class_link;

  Student(id, student_name, student_email, student_password,
      student_phone_number, auth_level, class_link) {
    this.id = id;
    this.student_name = student_name;
    this.student_email = student_email;
    this.student_password = student_password;
    this.student_phone_number = student_phone_number;
    this.auth_level = auth_level;
    this.class_link = class_link;
  }
}