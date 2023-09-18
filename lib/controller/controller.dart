import 'dart:convert';
import 'package:fluttertest/model/comment_model.dart';
import 'package:fluttertest/model/post_model.dart';
import 'package:http/http.dart' as http;

class Controller {
  Future<List<PostModel>> getData() async {
    List<PostModel>? data;
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts')).then((value) {
      final parsed = json.decode(value.body).cast<Map<String, dynamic>>();
      data = parsed.map<PostModel>((json) => PostModel.fromJson(json)).toList();
    });
    return data!;
  }

  Future<List<CommentModel>> getComment(int id) async{
    List<CommentModel>? data;
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments?postId=$id')).then((value) {
      final parsed = json.decode(value.body).cast<Map<String, dynamic>>();
      data = parsed.map<CommentModel>((json) => CommentModel.fromJson(json)).toList();
    });
    return data!;
  }
}
