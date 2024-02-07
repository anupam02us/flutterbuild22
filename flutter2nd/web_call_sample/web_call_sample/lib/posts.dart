import 'package:dio/dio.dart';

class Post{
  int userId;
  int id;
  String title;
  String body;
  Post({
    this.userId = 0,
     this.id = 0,
    this.title = "",
    this.body = "",
  });

  Post? fromJson(Map<String, dynamic> json){
    return Post()
    ..userId = json['userId'] as int
    ..id = json['id'] as int
    ..title = json['title'] as String
    ..body = json['body'] as String; 
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,       
      'id': id,     
      'title': title,     
      'body': body       
    };
  }

  Post feedDataFromResponse(Response response){
    return this
    ..userId = response.data['userId'] as int
    ..id = response.data['id'] as int
    ..title = response.data['title'] as String
    ..body = response.data['body'] as String; 
  }
}
