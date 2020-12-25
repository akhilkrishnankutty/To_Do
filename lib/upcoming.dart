import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/flutter_swipe_action_cell.dart';
import 'package:to_dos/home2.dart';

import 'database.dart';
import 'package:platform_date_picker/platform_date_picker.dart';
class Up extends StatefulWidget {
  @override
  _UpState createState() => _UpState();
}

class _UpState extends State<Up> {
  GlobalKey<FormState> _add = new GlobalKey<FormState>();
   String _todo;
  DateTime date = DateTime.now();
   final dbHelper = dbs.instance;
    List<String> litems = [];
  @override
  Widget build(BuildContext context) {
    
    var sc = MediaQuery.of(context);
    // final dbHelper = dbs.instance;
    return Scaffold(
      appBar: AppBar(title: Text("UPComing"),backgroundColor: Color(0xff232526),),
       body: SingleChildScrollView(
              child: Column(
          children: [
           Container(
              decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end:
              Alignment(0.8, 0.0),
          colors: [
            const Color(0xff0F2027),
            const Color(0xff203A43)
          ], // red to yellow
         
        ),
      ),
            //  color: Colors.red,
             height: sc.size.height,
    //          child: ListView.builder(
    //                itemCount: litems.length,
    //                itemBuilder: (BuildContext context, int index) {
    //                 //  return Card(
    //                 //    child:Text(litems[index])
    //                 //  );
    // //                return SwipeActionCell(
    // //   key: ObjectKey(litems[index]),///this key is necessary
    // //   trailingActions: <SwipeAction>[
    // //     SwipeAction(
    // //         title: "delete",
    // //         onTap: (CompletionHandler handler) async {
    // //           _delete();
    // //           litems.removeAt(index);
    // //           setState(() {});
    // //         },
    // //         color: Colors.red),
    // //   ],
    // //   child: Padding(
    // //     padding: const EdgeInsets.all(8.0),
    // //     child: Text("${litems[index]}",
    // //         style: TextStyle(fontSize: 40)),
    // //   ),
    // // );;
    //               },
    //              ) ,
             child: FutureBuilder(
               future: _test(),
               initialData: litems,
               builder: (BuildContext context, AsyncSnapshot snapshot) {
                 return ListView.builder(
                   itemCount: litems.length,
                   itemBuilder: (BuildContext context, int index) {
                    //  return Card(
                    //    child:Text(litems[index])
                    //  );
                   return Card(
                    //  shape: Shape,
                    color: Colors.blueAccent,
                                        child: SwipeActionCell(
                                          backgroundColor: Color(0xff2C5364),
      key: ObjectKey(dbHelper.queryAllRows()),///this key is necessary
      trailingActions: <SwipeAction>[
        SwipeAction(onTap: (CompletionHandler handler)async{
          _delete();
          see(context);
        },
        title:'Edit',
        color: Color(0xff1565C0)
        ),
        SwipeAction(
            title: "delete",
            onTap: (CompletionHandler handler) async {
              _delete();
              Navigator.push(context, MaterialPageRoute(builder: (context) => Home2()));
              litems.clear();
              litems.removeAt(index);
              setState(() {});
            },
            color: Color(0xffb92b27)),
      ],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("${litems[index]}",
            style: TextStyle(fontSize: 40)),
      ),
    ),
                   );
                  },
                 ) ;
               },
             ),
           ),]))
    );
  
  
  
  
  
  
  }


 void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }
 Future<void> _test() async{
    litems.clear();
    final allRows = await dbHelper.queryAllRows();
    
    print('query all rows:');
    allRows.forEach((row) => 
  
    { 
      // litems.clear(),
      print(allRows),
      // Future <List> _stodo = dbHelper.queryAllRows(),
   
     
      litems.add(row.toString().substring(9).replaceAll('}','')),
      
      // litems.add(row.toString().replaceAll('{',' ').replaceAll('}','').replaceAll('sub:', '')),
      print(litems),
      // print(row['_id'].toString())
    }
    );
    }


    void _insert() async {
  // var da = DateTime.now();
  // var ss = da.toString().substring(0,10);
  
  // print(ss);
  _add.currentState.save();
  // dbHelper.ins(ss,_todo);
    Map<String, dynamic> row = {
      // DatabaseHelper.columnName : _todo,
      // DatabaseHelper.columnAge  : ss,
      dbs.sub: _todo,
      dbs.date: date.toString().substring(0,10),
      
      
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
    print('asa');
    _add.currentState.reset();
  }

void see(context){
    var sc = MediaQuery.of(context);
    showDialog(context: context,
    child: SimpleDialog(
      children: [
        SimpleDialogOption(
          child:  Card(
            //  color:Colors.black,
             child: Column(
               children: [
                 Row(children: [
                   Form(
                     key: _add,
                    //  child: Text('eee'),
                    // child: TextFormField()
                    child: SizedBox(
                      width: sc.size.width/1.7,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Enter Subjet",
                        ),
                        onSaved: (input){
                            _todo = input;
                        },
                      ),
                    ),
                    ),
                  
                 ],),
                  ElevatedButton.icon(onPressed: (){
                 _insert();
                print(date);
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Home2()));
                // _query();
               }, icon: Icon(Icons.add), label: Text('Add')),
                RaisedButton(
              // height: 70,
              // minWidth: double.infinity,
              color: Colors.lightBlue,
              child: Text('Select Date'),
              onPressed: () async {
                DateTime temp = await PlatformDatePicker.showDate(
                  context: context,
                  firstDate: DateTime(DateTime.now().year - 2),
                  initialDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 2),
                  builder: (context, child) => Theme(
                    data: ThemeData.light().copyWith(
                      primaryColor: const Color(0xFF8CE7F1),
                      accentColor: const Color(0xFF8CE7F1),
                      colorScheme:
                          ColorScheme.light(primary: const Color(0xFF8CE7F1)),
                      buttonTheme:
                          ButtonThemeData(textTheme: ButtonTextTheme.primary),
                    ),
                    child: child,
                  ),
                );
                if (temp != null) setState(() => date = temp);
                print(date);
              },
            ),
               ],
             )
           ),
        )
      ],
    )
    
    );
  }


  
}