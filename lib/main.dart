import 'package:flutter/material.dart';
import "data.dart";

void main() {
  runApp(PostsApp());
}

// start to build the UI
class PostsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Posts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PostAppPage(),
    );
  }
}

class PostAppPage extends StatefulWidget {
  PostAppPage({Key key}) : super(key: key);

  @override
  _PostAppPageState createState() => _PostAppPageState();
}

class _PostAppPageState extends State<PostAppPage> {
  var data = new Data();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Posts App"), actions: <Widget>[
          // Add 3 lines from here...
          new IconButton(
              icon: const Icon(Icons.refresh), onPressed: () => _reloadData()),
        ]),
        body: ListView.builder(
            itemCount: data.posts.length,
            itemBuilder: (BuildContext context, int position) {
              return getRow(position);
            }));
  }

  // user will select specific row from the ListView
  Widget getRow(int i) {
    final title = data.getTitle(i);
    final body = data.getBody(i);
    final userName = data.getUserName(i);
    final commentCount = data.getCommentCount(i);
    return new ListTile(
        title: new Text(title),
        leading: new Icon(Icons.local_post_office),
        onTap: () {
          _displayRow(title, body, userName, commentCount);
        });
  }

  // display the details of the selected row in a new screen
  void _displayRow(
      String title, String body, String userName, int commentCount) {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('$userName wrote...'),
            ),
            body: _displayPost(title, body, commentCount),
          );
        },
      ),
    );
  }

  // simple layout to show post contents
  Widget _displayPost(String title, String body, int commentCount) {
    Widget _title = new Container(
      padding: new EdgeInsets.all(8.0),
      color: new Color(0X33000000),
      child: new Text('Title: $title',
          style: new TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          )),
    );

    Widget _body = new Expanded(
      child: new Container(
        padding: new EdgeInsets.all(8.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Text(body,
                style: new TextStyle(
                  fontSize: 18.0,
                )),
          ],
        ),
      ),
    );

    Widget _commentCount = new Container(
      padding: new EdgeInsets.all(8.0),
      color: new Color(0X33000000),
      height: 48.0,
      child: new Center(
        child: new Text(
            commentCount == 1
                ? '$commentCount comment'
                : '$commentCount comments',
            style: new TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            )),
      ),
    );

    Widget _content = new Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _title,
        _body,
        _commentCount,
      ],
    );

    return _content;
  }

  void loadData() async {
    await data.loadData();
    // when you load data we notify the UI
    setState(() {
      debugPrint("loaded data");
    });
  }

  void _reloadData() {
    debugPrint("reloading data..");
    loadData();
  }
}
