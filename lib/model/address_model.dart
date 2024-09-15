class Address {
  int? id;
  String? street;
  String? city;
  String? province;
  String? country;
  String? postalCode;

  Address(
      {this.id,
        this.street,
        this.city,
        this.province,
        this.country,
        this.postalCode});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    street = json['street'];
    city = json['city'];
    province = json['province'];
    country = json['country'];
    postalCode = json['postal_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['street'] = this.street;
    data['city'] = this.city;
    data['province'] = this.province;
    data['country'] = this.country;
    data['postal_code'] = this.postalCode;
    return data;
  }
}

//   Data? data;
//
//   Address({this.data});
//
//   Address.fromJson(Map<String, dynamic> json) {
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class Data {