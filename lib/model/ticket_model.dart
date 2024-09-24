import 'package:teater_jkt/model/show_model.dart';

import 'contact_model.dart';

class Data {
  Data? data;

  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
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

class Ticket {
  int? id;
  String? seatNumber;
  String? photo;
  String? purchaseDate;
  String? status;
  int? contactId;
  int? showId;
  Contact? contact;
  Show? show;

  Ticket(
      {this.id,
        this.seatNumber,
        this.photo,
        this.purchaseDate,
        this.status,
        this.contactId,
        this.showId,
        this.contact,
        this.show});

  Ticket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    seatNumber = json['seatNumber'];
    photo = json['photo'];
    purchaseDate = json['purchaseDate'];
    status = json['status'];
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
    data['status'] = this.status;
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
