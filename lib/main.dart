import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'search_bar.dart';

void main() => runApp(new MyApp());

const themeColor = 0xFF508BED;
const colorLeft = 0xFF667EA2;
const colorRight = 0xFF324075;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Api Filter list Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new SearchHomePage(),
    );
  }
}

class SearchHomePage extends StatefulWidget {
  // ExamplePage({ Key key }) : super(key: key);
  @override
  _SearchHomePageState createState() => new _SearchHomePageState();
}

class _SearchHomePageState extends State<SearchHomePage> {
  // final formKey = new GlobalKey<FormState>();
  // final key = new GlobalKey<ScaffoldState>();
  static final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();
  Icon _searchIcon = new Icon(Icons.search);

  @override
  void initState() {
    this._getNames();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            child: _buildList(),
          )),
      resizeToAvoidBottomPadding: false,
    );
  }

  void setSearchKeyword(String val) {
    setState(() {
      _searchText = val;
    });
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: Container(
        margin: EdgeInsets.all(),
        child: SearchBar()),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(colorLeft), Color(colorRight)],
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    if (!(_searchText.isEmpty)) {
      List tempList = new List();
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]['name']
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return ListView.builder(
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return new ListTile(
          title: Text(filteredNames[index]['name']),
          onTap: () => print(filteredNames[index]['name']),
        );
      },
    );
  }

  void _getNames() async {
    final response = await dio.get('https://swapi.co/api/people');
    List tempList = new List();
    for (int i = 0; i < response.data['results'].length; i++) {
      tempList.add(response.data['results'][i]);
    }
    setState(() {
      names = tempList;
      names.shuffle();
      filteredNames = names;
    });
  }
}
