import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';




class dbs{
  
  static final _dbname = "todo.db";
  static final _dbv = 2;
  static final table = "todo_table";
  static final date = "date";
  static final sub = "sub";
    static final columnId = '_id';
  dbs._pv();
  static final dbs instance = dbs._pv();

  static Database _database;
  Future<Database> get database async{
     if (_database != null) return _database;
    
    _database = await _initDatabase();
    return _database;
  }
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbname);
    return await openDatabase(path,
        version: _dbv,
        onCreate: _onCreate);
  }
  Future _onCreate(Database db, int version) async {
    print('db created');
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $date TEXT,
            $sub TEXT NOT NULL
          )
          ''');
  }


 Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }
Future ins(da,na)async{
  Database db = await instance.database;
  return await db.rawQuery('INSERT INTO $table(date,sub) VALUES($da,$na)');
   
}

  // All of the rows are returned as a list of maps, where each map is 
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.rawQuery('SELECT * FROM $table');
  }
   Future<List<Map<String, dynamic>>> queryToday() async {
     var da = DateTime.now();
     var ss = da.toString().substring(0,10);
    Database db = await instance.database;
    // return await db.rawQuery('SELECT * FROM $table');
    // return await db.rawQuery('SELECT * FROM $table WHERE date=2020-12-25');
    return await db.query(table,where:'$date = ?',whereArgs: [ss]);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  // We are assuming here that the id column in the map is set. The other 
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is 
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

}


