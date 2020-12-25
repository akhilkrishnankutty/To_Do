import 'dart:async';

import 'package:flutter/material.dart';
import 'package:to_dos/database.dart';
import 'package:to_dos/home.dart';
import 'package:to_dos/home2.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    
    super.initState();{
  //     final dbHelper = dbs.instance;
  //     List<String> litems = [];
  //     Future<void> _test() async{
  //   final allRows = await dbHelper.queryAllRows();
  //   print('query all rows:');
  //   allRows.forEach((row) => 
  //   // print(row)
  //   {
  //     print('inside'),
  //     litems.add(row.toString()),
  //     print(litems)
  //   }
  //   );
    
    
  //   print(litems);
  // }
  // _test();
      Timer(
        Duration(microseconds: 1),
        (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Home2(
            // stodo: litems,
          )));
        }
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child:Align(
          alignment: Alignment.center,
                  child: Center(
            child:Column(
              children: [
                Text("Todo"),
                CircularProgressIndicator(),
              ],
            )
          ),
        )
      )
    );
  }
}