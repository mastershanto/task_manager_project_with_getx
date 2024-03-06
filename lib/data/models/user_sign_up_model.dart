
class UserSignUpModel {
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;
  String? photo;
  String? password;

  UserSignUpModel(
      {this.email, this.firstName, this.lastName, this.mobile, this.photo, this.password});

  UserSignUpModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    photo = json['photo'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['mobile'] = mobile;
    data['photo'] = photo;
    data['password'] = password;
    return data;
  }
}