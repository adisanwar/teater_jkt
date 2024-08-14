import 'contact_model.dart';
import 'show_model.dart';

class TicketModel {
  final Show = ShowModel();
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
  String? purchaseDate;
  int? contactId;
  int? showId;
  ContactModel? contact;
  ShowModel? show;

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
    json['contact'] != null ? new ContactModel.fromJson(json['contact']) : null;
    show = json['show'] != null ? new ShowModel.fromJson(json['show']) : null;
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


