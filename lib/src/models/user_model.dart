class UserModel {
  String? id;
  String email;
  String password;
  String mobNo;
  String name;
  String? address;

  UserModel(
      {this.id,
      required this.email,
      required this.password,
      required this.mobNo,
      required this.name,
       this.address});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      email: json["email"],
      password: json["password"],
      mobNo: json["mobNo"],
      name: json["name"],
      address: json["address"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "email": this.email,
      "password": this.password,
      "mobNo": this.mobNo,
      "name": this.name,
      "address": this.address,
    };
  }
//

}
