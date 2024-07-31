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
  int? theaterId;
  Theater? theater;

  Data(
      {this.id,
      this.title,
      this.photo,
      this.description,
      this.duration,
      this.rating,
      this.theaterId,
      this.theater});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    photo = json['photo'];
    description = json['description'];
    duration = json['duration'];
    rating = json['rating'];
    theaterId = json['theaterId'];
    theater =
        json['theater'] != null ? new Theater.fromJson(json['theater']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['photo'] = this.photo;
    data['description'] = this.description;
    data['duration'] = this.duration;
    data['rating'] = this.rating;
    data['theaterId'] = this.theaterId;
    if (this.theater != null) {
      data['theater'] = this.theater!.toJson();
    }
    return data;
  }
}

class Theater {
  int? id;
  String? name;
  Null? photo;
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
