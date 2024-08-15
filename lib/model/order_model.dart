import 'package:teater_jkt/model/ticket_model.dart';

class Data {
  List<Order>? data;

  Data({this.data});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Order>[];
      json['data'].forEach((v) {
        data!.add(new Order.fromJson(v));
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



class Order {
  int? id;
  String? orderId;
  int? amount;
  String? status;
  String? paymentUrl;
  int? ticketId;
  Ticket? ticket;

  Order(
      {
        this.id,
        this.orderId,
        this.amount,
        this.status,
        this.paymentUrl,
        this.ticket, 
        this.ticketId, 
        });

  Order.fromJson(Map<String, dynamic> json) {
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


