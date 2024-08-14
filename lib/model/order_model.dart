class OrderModel {
  List<Data>? data;

  OrderModel({this.data});

  OrderModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? orderId;
  int? amount;
  String? status;
  String? paymentUrl;
  int? ticketId;
  Ticket? ticket;

  Data(
      {
        this.id,
        this.orderId,
        this.amount,
        this.status,
        this.paymentUrl,
        this.ticket, 
        this.ticketId, 
        });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['orderId'];
    amount = json['amount'];
    status = json['status'];
    paymentUrl = json['paymentUrl'];
    ticketId = json['ticketId'];
    ticket =
    json['ticket'] != null ? new Ticket.fromJson(json['ticket']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderId'] = this.orderId;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['paymentUrl'] = this.paymentUrl;
    data['ticketId'] = this.ticketId;
    if (this.ticket != null) {
      data['ticket'] = this.ticket!.toJson();
    }
    return data;
  }
}

class Ticket {
  int? id;
  String? seatNumber;
  Null? purchaseDate;
  int? contactId;
  int? showId;
  Show? show;

  Ticket(
      {this.id,
        this.seatNumber,
        this.purchaseDate,
        this.contactId,
        this.showId,
        this.show});

  Ticket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    seatNumber = json['seatNumber'];
    purchaseDate = json['purchaseDate'];
    contactId = json['contactId'];
    showId = json['showId'];
    show = json['show'] != null ? new Show.fromJson(json['show']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seatNumber'] = this.seatNumber;
    data['purchaseDate'] = this.purchaseDate;
    data['contactId'] = this.contactId;
    data['showId'] = this.showId;
    if (this.show != null) {
      data['show'] = this.show!.toJson();
    }
    return data;
  }
}

class Show {
  int? id;
  String? title;
  String? description;
  String? duration;
  String? rating;

  Show({this.id, this.title, this.description, this.duration, this.rating});

  Show.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    duration = json['duration'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['rating'] = this.rating;
    return data;
  }
}
