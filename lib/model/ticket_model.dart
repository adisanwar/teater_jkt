import 'contact_model.dart';
import 'show_model.dart';

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

  Ticket({
    this.id,
    this.seatNumber,
    this.photo,
    this.purchaseDate,
    this.status,
    this.contactId,
    this.showId,
    this.contact,
    this.show,
  });

  Ticket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    seatNumber = json['seatNumber'];
    photo = json['photo'];
    purchaseDate = json['purchaseDate'];
    status = json['status'];
    contactId = json['contactId'];
    showId = json['showId'];
    contact = json['contact'] != null ? Contact.fromJson(json['contact']) : null;
    show = json['show'] != null ? Show.fromJson(json['show']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['seatNumber'] = seatNumber;
    data['status'] = status;
    data['photo'] = photo;
    data['purchaseDate'] = purchaseDate;
    data['contactId'] = contactId;
    data['showId'] = showId;
    if (contact != null) {
      data['contact'] = contact!.toJson();
    }
    if (show != null) {
      data['show'] = show!.toJson();
    }
    return data;
  }
}
