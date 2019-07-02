import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final Function searchTextChange;

  SearchBar({Key key, this.searchTextChange}) : super(key: key);

  _SearchBarState createState() => _SearchBarState(searchTextChange);
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _filter = new TextEditingController();

  FocusNode _focusNode = new FocusNode();
  String _searchText = "";
  Icon _searchIcon = new Icon(Icons.search);
  var focused = false;

  @override
  void initState() {
    super.initState();
  }

  void _onFocusChange() {
    debugPrint("Focus: " + _focusNode.hasFocus.toString());
  }

  _SearchBarState(_searchTextChange) {
    this._filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          this.widget.searchTextChange("");
        });
      } else {
        setState(() {
          _searchText = _filter.text;
          this.widget.searchTextChange(_filter.text);
        });
      }
    });
    this._focusNode.addListener(_onFocusChange);
  }

  @override
  Widget build(BuildContext context) {
    return new TextField(
        controller: this._filter,
        focusNode: _focusNode,
        // maxLength: 30,
        onTap: () => {focused = true},
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(50.0),
            ),
          ),
          filled: true,
          fillColor: Colors.white24,
          contentPadding: new EdgeInsets.all(7),
          hintStyle: new TextStyle(color: Colors.grey[800]),
          hintText: "Type in your text",
        ),
        style: new TextStyle(color: Colors.white));
  }
}
