class UserModel{
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String? password;


  UserModel({this.uid, this.email, this.firstName, this.lastName,this.password});

  // Receiving  data from server
  factory UserModel.formMap(map){
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        password: map['password'],
      firstName: map['firstName'],
        lastName: map['lastName'],



    );
  }
  // Sending data to a server
  Map<String ,dynamic>toMap(){
    return{
      'uid':uid,
      'email':email,
      'password':password,
      'firstName':firstName,
      'lastName':lastName,

    };
  }
}