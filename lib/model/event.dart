import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String? id;
  String? title;
  String? description;
  Timestamp? dateTime;
  String? type;
  String? userId;
  Event({this.id,this.title,this.description,this.dateTime,this.type,this.userId});

  Event.fromFirestore(Map<String,dynamic>? data){
    id = data?["id"];
    title = data?["title"];
    description = data?["description"];
    dateTime = data?["dateTime"];
    type = data?["type"];
    userId = data?["userId"];
  }

  Map<String,dynamic>toFirestore(){
    return {
      "id":id,
      "title":title,
      "description":description,
      "dateTime":dateTime,
      "type":type,
      "userId":userId,
    };
  }
}