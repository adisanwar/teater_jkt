
// Pastikan ini sudah diimpor jika model ContactModel berada di file terpisah

class UserModel {
  String? name;
  String? username;
  String? password;
  String? token;
  bool? isAdmin;

  UserModel({
    this.name,
    this.username,
    this.password,
    this.token,
    this.isAdmin,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    username = json['username'];
    password = json['password'];
    token = json['token'];
    isAdmin = json['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['username'] = username;
    data['password'] = password;
    data['token'] = token;
    data['isAdmin'] = isAdmin;
    return data;
  }
}
