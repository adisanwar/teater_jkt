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