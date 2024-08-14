class TicketModel {
  Data? data;

  TicketModel({this.data});

  TicketModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? seatNumber;
  String? photo;
  Null? purchaseDate;
  int? contactId;
  int? showId;
  Contact? contact;
  Show? show;

  Data(
      {this.id,
        this.seatNumber,
        this.photo,
        this.purchaseDate,
        this.contactId,
        this.showId,
        this.contact,
        this.show});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    seatNumber = json['seatNumber'];
    photo = json['photo'];
    purchaseDate = json['purchaseDate'];
    contactId = json['contactId'];
    showId = json['showId'];
    contact =
    json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
    show = json['show'] != null ? new Show.fromJson(json['show']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seatNumber'] = this.seatNumber;
    data['photo'] = this.photo;
    data['purchaseDate'] = this.purchaseDate;
    data['contactId'] = this.contactId;
    data['showId'] = this.showId;
    if (this.contact != null) {
      data['contact'] = this.contact!.toJson();
    }
    if (this.show != null) {
      data['show'] = this.show!.toJson();
    }
    return data;
  }
}

class Contact {
  int? id;
  String? fullname;
  Null? photo;
  String? email;
  String? phone;
  Null? dateofbirth;
  Null? ofcNo;
  Null? nationalId;

  Contact(
      {this.id,
        this.fullname,
        this.photo,
        this.email,
        this.phone,
        this.dateofbirth,
        this.ofcNo,
        this.nationalId});

  Contact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    photo = json['photo'];
    email = json['email'];
    phone = json['phone'];
    dateofbirth = json['dateofbirth'];
    ofcNo = json['ofcNo'];
    nationalId = json['nationalId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullname'] = this.fullname;
    data['photo'] = this.photo;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['dateofbirth'] = this.dateofbirth;
    data['ofcNo'] = this.ofcNo;
    data['nationalId'] = this.nationalId;
    return data;
  }
}

class Show {
  int? id;
  String? title;
  Null? photo;
  Null? price;
  String? description;
  String? duration;
  String? rating;

  Show(
      {this.id,
        this.title,
        this.photo,
        this.price,
        this.description,
        this.duration,
        this.rating});

  Show.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    photo = json['photo'];
    price = json['price'];
    description = json['description'];
    duration = json['duration'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['photo'] = this.photo;
    data['price'] = this.price;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['rating'] = this.rating;
    return data;
  }
}
