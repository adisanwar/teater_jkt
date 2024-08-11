class ContactModel {
  int? id;
  String? fullname;
  String? photo;
  String? email;
  String? phone;
  DateTime? dateofbirth;
  String? ofcNo;
  BigInt? nationalId;
  String? username;

  ContactModel({
    this.id,
    this.fullname,
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
    fullname = json['fullname'];
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
    data['fullname'] = fullname;
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
