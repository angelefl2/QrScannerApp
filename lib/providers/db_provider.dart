/*Esta clase es un singleton porque no importa donde lo importes o donde lo utilices que siempre va a coer
la misma instancia de la clase.*/

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:qrreader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  final dataBaseVersion = 1;
  static Database? _database;
  static final DBProvider db = DBProvider._(); // Constructor privado
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    // Path de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // Join se usa para unir la ruta de documentos de la app al nombre de la base de datos
    final path = join(documentsDirectory.path, "ScansDB.db");
    print("La ruta de labase de datos: $path");
    return await openDatabase(
      path,
      version:
          dataBaseVersion, // nº de version, es lo que se itera cuando hay cambios
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        // Esto es un string Multilinea
        await db.execute('''
        CREATE TABLE Scans (
          id INTEGER PRIMARY KEY,
          tipo TEXT,
          valor TEXT
        )
        ''');
      },
    );
  }

  nuevoScanRaw(ScanModel scan) async {
    final id = scan.id;
    final tipo = scan.tipo;
    final valor = scan.valor;
    // Verificamos la base de datos
    final db = await database;
    final res = await db.rawInsert('''
    INSERT INTO Scans (id, tipo, valor)
      VALUES ($id, $tipo, $valor)
    ''');

    return res;
  }

  Future<int> nuevoScan(ScanModel scan) async {
    // Verificamos la base de datos
    final db = await database;
    final res = await db.insert(
        "Scans", scan.toJson()); // El res es id del ultimo registro insertado.
    return res;
  }

  Future<ScanModel> getScanById(int id) async {
    final db = await database;
    final res = await db.query("Scans", where: "id = ?", whereArgs: [id]);
    // Traemos el primer elemento porue como buscamos por id, entendemos que solamente viene un registro.
    // sino, devolvemos un scanModel vacio.
    return res.isNotEmpty
        ? ScanModel.fromJson(res.first)
        : ScanModel(valor: "");
  }

  Future<List<ScanModel>> getTodosLosScans() async {
    final db = await database;
    final res = await db.query("Scans");

    if (res.isNotEmpty) {
      return res.map((scan) => ScanModel.fromJson(scan)).toList();
    } else {
      return [];
    }
  }

  Future<List<ScanModel>> getScansPorTipo(String tipo) async {
    final db = await database;
    final res = await db.rawQuery('''
    SELECT * FROM Scans WHERE tipo = "$tipo";
    ''');

    if (res.isNotEmpty) {
      return res.map((scan) => ScanModel.fromJson(scan)).toList();
    } else {
      return [];
    }
  }

  Future<int> updateScan(ScanModel scan) async {
    final db = await database;
    final res = await db
        .update("Scans", scan.toJson(), where: 'id = ?', whereArgs: [scan.id]);
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete("Scans", where: ' id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScans() async {
    final db = await database;
    //final res = await db.delete("Scans");
    // Tambien se puede haer asi 
    final res = await db.rawDelete('''
    DELETE FROM Scans
    ''');
    return res;
  }
}
