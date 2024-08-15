import 'package:teater_jkt/model/showtime_model.dart';
import 'package:teater_jkt/model/theater_model.dart';

class Data {
  List<Show>? shows;

  Data({this.shows});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      shows = <Show>[];
      json['data'].forEach((v) {
        shows!.add(Show.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.shows != null) {
      data['data'] = this.shows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Show {
  int? id;
  String? title;
  String? photo;
  String? description;
  String? duration;
  String? rating;
  int? price;
  int? theaterId;
  int? showtimeId;
  Theater? theater;
  Showtime? showtime;

  Show({
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

  Show.fromJson(Map<String, dynamic> json) {
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
        ? Theater.fromJson(json['theater'])
        : null;
    showtime = json['showtime'] != null
        ? Showtime.fromJson(json['showtime'])
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
