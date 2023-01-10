import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

import 'product_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final wordPair = WordPair.random();
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.menu),
        //   tooltip: 'menu',
        //   onPressed: null,
        // ),
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(onPressed: null, icon: Icon(Icons.search), tooltip: 'Search')
        ],
      ),
      drawer: Drawer(
        //슬라이드 메뉴
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget> [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('images/bottle.jpg'),
              ),
              accountName: Text('이정우'),
              accountEmail: Text('dlwjddn22@gmail.com'),
              onDetailsPressed: (){},
              decoration: BoxDecoration(
                //color: Colors.amber[600],
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )
              ),
              otherAccountsPictures: [
                CircleAvatar(
                  backgroundImage: AssetImage('images/bottle.jpg'),
                  backgroundColor: Colors.white,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage('images/bottle.jpg'),
                  backgroundColor: Colors.white,
                ),
              ],
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.grey[850]
                ),
              title: Text('Home'),
              onTap: (){
                print('Home click');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProductInfo()),
                );
              },
              trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(
                  Icons.settings,
                  color: Colors.grey[850]
              ),
              title: Text('Setting'),
              onTap: (){
                print('Setting click');
              },
              trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(
                  Icons.question_answer,
                  color: Colors.grey[850]
              ),
              title: Text('Q&A'),
              onTap: (){
                print('Q&A click');
              },
              trailing: Icon(Icons.add),
            ),
          ],
        ),
      ),
      //body: _buildSuggestions(),
      body: _buildSuggestions(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductInfo()),
          );
        },
        tooltip: '상품소개로 이동',
        child: const Icon(Icons.near_me),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

