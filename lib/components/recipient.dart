import 'package:flutter/material.dart';

class RecipientCard extends StatelessWidget {
  const RecipientCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(15, 0, 5, 0),
        height: 65,
        decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(color: Theme.of(context).dividerColor)),
          boxShadow: [
            BoxShadow(color: Color(0x000C26), blurRadius: 15, spreadRadius: -4,offset: Offset.zero)
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    child: Image.asset('assets/images/305.png',
                        height: 30, width: 30))
              ],
            ),
            Container(
                margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(children: <Widget>[Text('收款人'), Text('别名别名')]),
                    Row(children: <Widget>[Text('收款人'), Text('别名别名')])
                  ],
                ))
          ],
        ));
  }
}
