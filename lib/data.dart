import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:posts/post.dart';
import 'package:posts/user.dart';
import 'package:posts/comment.dart';

class Data {
  List<Post> posts = [];
  List<User> users = [];
  List<Comment> comments = [];

  List<Post> parsePosts(String responseBody) {
    final parsed = json.decode(responseBody);
    return parsed.map<Post>((json) => Post.fromJson(json)).toList();
  }

  List<User> parseUsers(String responseBody) {
    final parsed = json.decode(responseBody);
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  List<Comment> parseComments(String responseBody) {
    final parsed = json.decode(responseBody);
    return parsed.map<Comment>((json) => Comment.fromJson(json)).toList();
  }

  String getTitle(int i) {
    return posts[i].title;
  }

  String getBody(int i) {
    return posts[i].body;
  }

  String getUserName(int i) {
    final userId = posts[i].userId;
    return users.firstWhere((user) => user.id == userId).username;
  }

  int getCommentCount(int i) {
    final postId = posts[i].id;
    return comments.where((comment) => comment.postId == postId).length;
  }

  loadData() async {
    String postsURL = "https://jsonplaceholder.typicode.com/posts";
    String usersURL = "https://jsonplaceholder.typicode.com/users";
    String commentsURL = "https://jsonplaceholder.typicode.com/comments";
    http.Response postsResponse = await http.get(postsURL);
    http.Response usersResponse = await http.get(usersURL);
    http.Response commentsResponse = await http.get(commentsURL);
    // check the HTTP responses
    if (postsResponse.statusCode == 200 &&
        usersResponse.statusCode == 200 &&
        commentsResponse.statusCode == 200) {
      posts = parsePosts(postsResponse.body);
      users = parseUsers(usersResponse.body);
      comments = parseComments(commentsResponse.body);
    } else {
      throw Exception('Failed to load post');
    }
  }
}
