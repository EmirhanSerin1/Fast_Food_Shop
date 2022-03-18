class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? sex;

  UserModel({this.uid, this.email, this.firstName, this.secondName, this.sex});

  //For receive data
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      sex: map['sex'],
    );
  }

  //For send data
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'sex': sex,
    };
  }
}
