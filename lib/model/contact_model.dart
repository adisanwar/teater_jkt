class ContactModel {
  int? id;
  String? firstName;
  String? lastName;
  String? photo;
  String? email;
  String? phone;
  DateTime? dateofbirth;
  String? ofcNo;
  BigInt? nationalId;
  String? username;

  ContactModel({
    this.id,
    this.firstName,
    this.lastName,
    this.photo,
    this.email,
    this.phone,
    this.dateofbirth,
    this.ofcNo,
    this.nationalId,
    this.username,
  });

  ContactModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    photo = json['photo'];
    email = json['email'];
    phone = json['phone'];
    dateofbirth = DateTime.tryParse(json['dateofbirth'] ?? '');
    ofcNo = json['ofcNo'];
    nationalId = BigInt.tryParse(json['nationalId'] ?? '');
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['photo'] = photo;
    data['email'] = email;
    data['phone'] = phone;
    data['dateofbirth'] = dateofbirth?.toIso8601String();
    data['ofcNo'] = ofcNo;
    data['nationalId'] = nationalId?.toString();
    data['username'] = username;
    return data;
  }
}
