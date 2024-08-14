import 'package:teater_jkt/model/showtime_model.dart';
import 'package:teater_jkt/model/theater_model.dart';

class ShowModel {
  List<Data>? data;

  ShowModel({this.data});

  ShowModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? photo;
  String? description;
  String? duration;
  String? rating;
  int? price;
  int? theaterId;
  int? showtimeId;
  TheaterModel? theater;
  ShowtimeModel? showtime;

  Data({
    this.id,
    this.title,
    this.photo,
    this.description,
    this.duration,
    this.rating,
    this.price,
    this.theaterId,
    this.showtimeId,
    this.theater,
    this.showtime,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    photo = json['photo'];
    description = json['description'];
    duration = json['duration'];
    rating = json['rating'];
    price = json['price'];
    theaterId = json['theaterId'];
    showtimeId = json['showtimeId'];
    theater = json['theater'] != null
        ? TheaterModel.fromJson(json['theater'])
        : null;
    showtime = json['showtime'] != null
        ? ShowtimeModel.fromJson(json['showtime'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['title'] = this.title;
    data['photo'] = this.photo;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['rating'] = this.rating;
    data['price'] = this.price;
    data['theaterId'] = this.theaterId;
    data['showtimeId'] = this.showtimeId;
    if (this.theater != null) {
      data['theater'] = this.theater!.toJson();
    }
    if (this.showtime != null) {
      data['showtime'] = this.showtime!.toJson();
    }
    return data;
  }
}
