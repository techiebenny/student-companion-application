class Student_class{
  int? dept_link;
  int? section_id;
  String? section_name;
  String? section_batch_join;
  String? section_classcode;

  Student_class(dept_link,section_id,section_name,section_batch_join,section_classcode){
    this.dept_link=dept_link;
    this.section_id=section_id;
    this.section_name=section_name;
    this.section_batch_join=section_batch_join;
    this.section_classcode=section_classcode;

  }

  @override
  String toString() {
    // TODO: implement toString
    return (dept_link.toString()+" "+section_id.toString()+" "+section_name!+" "+section_batch_join!+" "+section_classcode!);
  }
}
