import 'dart:convert';

class NotificationModel {
  final String id ;
  final String title;
  final String body;
  final DateTime dateTime;

  const NotificationModel({required this.title, required this.body , required this.id , required this.dateTime});
  Map<String, dynamic> toMap() {
    return {
      "title" : title ,
      "body" : body ,
      "id" : id ,
      "dateTime" : dateTime.toIso8601String()
    };
  }
  String toJson() => json.encode(toMap());
  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id : map['id'],
      dateTime: DateTime.parse(map['dateTime']),
      title: map['title'],
      body: map['body'],
    );
  }
  factory NotificationModel.fromJson(String source) => NotificationModel.fromMap(json.decode(source));
}
