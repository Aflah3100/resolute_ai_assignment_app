class UserModel {
  String fullName;
  String emailId;
  String mobileNo;

  UserModel(
      {required this.fullName, required this.emailId, required this.mobileNo});
  
  Map<String,dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': emailId,
      'mobile': mobileNo,
    };
  }
  
  factory UserModel.fromJson(Map<String,dynamic> userMap) {
    return UserModel(
      fullName: userMap['fullName'],
      emailId: userMap['email'],
      mobileNo: userMap['mobile'],
    );
  }
}
