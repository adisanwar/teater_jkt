class ShowModel {
  List<Data>? data;

  ShowModel({this.data});

  ShowModel.fromJson(Map<String, dynamic> json) {
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

  Data(
      {this.id,
        this.title,
        this.photo,
        this.description,
        this.duration,
        this.rating,
        this.price,
        this.theaterId,
        this.showtimeId,
        this.theater,
        this.showtime});

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
    theater =
    json['theater'] != null ? new Theater.fromJson(json['theater']) : null;
    showtime = json['showtime'] != null
        ? new Showtime.fromJson(json['showtime'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

class Theater {
  int? id;
  String? name;
  String? photo;
  String? location;
  String? capacity;

  Theater({this.id, this.name, this.photo, this.location, this.capacity});

  Theater.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    location = json['location'];
    capacity = json['capacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['photo'] = this.photo;
    data['location'] = this.location;
    data['capacity'] = this.capacity;
    return data;
  }
}

class Showtime {
  int? id;
  String? showDate;
  String? showTime;

  Showtime({this.id, this.showDate, this.showTime});

  Showtime.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    showDate = json['showDate'];
    showTime = json['showTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['showDate'] = this.showDate;
    data['showTime'] = this.showTime;
    return data;
  }
}
