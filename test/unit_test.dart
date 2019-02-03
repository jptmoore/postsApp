import 'package:flutter_test/flutter_test.dart';
import 'package:posts/data.dart';

void main() {

  var data = new Data();

  test('test data model', () async {
    await data.loadData();
    // check id of posts run sequentially
    for (var i = 0; i < data.posts.length; i++) {
      expect(data.posts[i].id, i + 1);
    }
    // check id of users run sequentially
    for (var i = 0; i < data.users.length; i++) {
      expect(data.users[i].id, i + 1);
    }
    // check comment count for all posts is 5
    for (var i = 0; i < data.posts.length; i++) {
      var commentCount =
          data.comments.where((comment) => comment.postId == data.posts[i].id).length;
      expect(commentCount, 5);
    }
    // check username for specific id
    var userName = data.users.firstWhere((user) => user.id == 5).username;
    expect(userName, "Kamren");
  });
}
