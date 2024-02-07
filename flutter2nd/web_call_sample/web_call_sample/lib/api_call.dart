import 'package:dio/dio.dart';
import 'package:web_call_sample/posts.dart';

class ApiCaller{
  final dio = Dio();
  Future<Post> getData() async {
    final response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
    Post posts = Post().feedDataFromResponse(response);
    return posts;
  }
}