import 'package:flutter/material.dart';
import 'my_util.dart';

class FutureWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Article>>(
        future: getServerData('1'),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return getWidget(snapshot.data ?? []);
          }else if(snapshot.hasError){
            return Text('${snapshot.error}');
          }
          return CircularProgressIndicator();
        }
    );
  }
}