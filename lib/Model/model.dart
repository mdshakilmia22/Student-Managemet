
class StudentModel{
  String ?studentName;
  String ? fathersName;
  String ? mothersName;
  dynamic roll;
  String ? birthDate;
  String ? studentLanguase;
  String ? studentInistitute;
  String ? studentGrup;
  String ? bloodGrup;
  String? className;
  String ? studentsContact;
  String ? pictureUrl;

  StudentModel({this.studentName, this.fathersName, this.mothersName, this.birthDate, this.studentLanguase, this.studentInistitute, this.studentGrup, this.bloodGrup, this.studentsContact, this.className, this.pictureUrl,this.roll});

  StudentModel.fromJson(dynamic json){
    studentName = json['studentName'];
    fathersName = json['fathersName'];
    mothersName =json['mothersName'];
    roll=json['rollNumber'];
    birthDate=json['birthDate'];
    studentLanguase=json['languase'];
    studentInistitute=json['inistitute'];
    studentGrup=json['grup'];
    bloodGrup =json['bloodGrup'];
    className =json['ClassName'];
    studentsContact=json['contact'];
    pictureUrl =json['pictureUrl'];
  }

  Map<String,dynamic> toJson () {
    final map= <String,dynamic>{};
    map['studentName']=studentName;
    map['fathersName']=fathersName;
    map['mothersName']=mothersName;
    map['rollNumber']=roll;
    map['birthDate']=birthDate;
    map['languase']= studentLanguase;
    map['inistitute']=studentInistitute;
    map['grup']= studentGrup;
    map['bloodGrup']=bloodGrup;
    map['ClassName']=className;
    map['contact'] =studentsContact;
    map['pictureUrl']=pictureUrl;
    return map;
}
}
