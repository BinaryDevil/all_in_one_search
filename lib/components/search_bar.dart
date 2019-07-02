import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final Function searchTextChange;
  final Function focusChange;

  SearchBar({Key key, this.searchTextChange, this.focusChange})
      : super(key: key);

  _SearchBarState createState() =>
      _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _filter = new TextEditingController();

  FocusNode _focusNode = new FocusNode();
  String _searchText = "";
  bool _searchFocus = false;
  Icon _searchIcon = new Icon(Icons.search);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();

    super.dispose();
  }

  void _onFocusChange() {
    _searchFocus = _focusNode.hasFocus;
    this.widget.focusChange(_searchFocus);
  }

  void _onSearchTextChange() {
    if (_filter.text.isEmpty) {
      setState(() {
        _searchText = "";
      });
    } else {
      setState(() {
        _searchText = _filter.text;
      });
    }
    this.widget.searchTextChange(_searchText);
  }

  _SearchBarState() {
    this._filter.addListener(_onSearchTextChange);
    this._focusNode.addListener(_onFocusChange);
  }

  Widget _buildInput() {
    return TextField(
        controller: this._filter,
        focusNode: _focusNode,
        // maxLength: 30,
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

  @override
  Widget build(BuildContext context) {
    var components = new List<Widget>();

    components.add(_buildInput());
    if (_searchFocus) {
      components
          .add(new Text('取消', style: TextStyle(color: Color(0xFF508BED))));
    }

    return _buildInput();
  }
}
