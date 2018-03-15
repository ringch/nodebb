import 'package:flutter/material.dart';
import 'package:nodebb/views/base.dart';
import 'package:nodebb/views/topics_fragment.dart';
import 'package:nodebb/views/messages_fragment.dart';
import 'package:nodebb/views/personal_fragment.dart';


class HomePage extends BasePage {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  int _currentIndex = 0;

  TabController _controller;

  @override
  void initState() {
    this._controller = new TabController(initialIndex: this._currentIndex, length: 3, vsync: this);
    this._controller.addListener(() {
      this.setState(() {
        this._currentIndex = this._controller.index;
      });
    });
  }


  BottomNavigationBar _buildBottomNavBar() {
    return new BottomNavigationBar(
      currentIndex: this._currentIndex,
      items: <BottomNavigationBarItem>[
        new BottomNavigationBarItem(icon: const Icon(Icons.explore), title: const Text('话题', style: const TextStyle(fontSize: 12.0))),
        new BottomNavigationBarItem(icon: const Icon(Icons.message), title: const Text('消息', style: const TextStyle(fontSize: 12.0))),
        new BottomNavigationBarItem(icon: const Icon(Icons.person), title: const Text('个人', style: const TextStyle(fontSize: 12.0)))
      ],
      onTap: (int index) {
        this._controller.animateTo(index);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text(widget.title)
      ),
      body: new NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification) {
            //print(ScrollNotification.toString());
          },
          child: new TabBarView(
              controller: this._controller,
              children: [
                new TopicsFragment(key: new ValueKey<String>('TopicsFragment')),
                new MessagesFragment(key: new ValueKey<String>('MessagesFragment')),
                new PersonalFragment(key: new ValueKey<String>('PersonalFragment'))
              ]
          )
      ),
      bottomNavigationBar: this._buildBottomNavBar(),
    );
  }
}
