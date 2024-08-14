class TheaterModel {
  int? id;
  String? name;
  String? photo;
  String? location;
  String? capacity;

  TheaterModel({this.id, this.name, this.photo, this.location, this.capacity});

  TheaterModel.fromJson(Map<String, dynamic> json) {
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


