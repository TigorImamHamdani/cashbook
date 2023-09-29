import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  final String tablePemasukanName = 'pemasukan';
  final String tablePengeluaranName = 'pengeluaran';
  final String tableUser = 'userLogin';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'managebooksss.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tablePemasukanName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            ketpemasukan TEXT,
            nominalpemasukan INTEGER,
            tanggalpemasukan TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE $tablePengeluaranName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            ketpengeluaran TEXT,
            nominalpengeluaran INTEGER,
            tanggalpengeluaran TEXT
          )
        ''');

         await db.execute('''
          CREATE TABLE $tableUser (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT,
            username TEXT,
            password TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
      },
    );
  }

  // LoginRegister
  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert(tableUser, user.toMap());
  }

  Future<User?> getUserByUsername(String email) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableUser,
      where: 'email = ?',
      whereArgs: [email],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<User?> getUserData() async {
  final dbHelper = DatabaseHelper(); 
  final db = await dbHelper.database;

  final List<Map<String, dynamic>> maps = await db.query(tableUser);

  if (maps.isNotEmpty) {
    return User(
      id: maps[0]['id'],
      username: maps[0]['username'],
      email: maps[0]['email'],
      password: maps[0]['password'],
    );
  }
  return null; // Return null jika data pengguna tidak ditemukan
}

  // CRUD operations for Pemasukan table
  Future<int> createPemasukanEntry(ManageBookPemasukanEntry entry) async {
    final db = await database;
    return await db.insert(tablePemasukanName, entry.toMap());
  }

  Future<List<ManageBookPemasukanEntry>> getPemasukanEntries() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tablePemasukanName);
    return List.generate(maps.length, (i) {
      return ManageBookPemasukanEntry(
        id: maps[i]['id'],
        ketpemasukan: maps[i]['ketpemasukan'],
        nominalpemasukan: maps[i]['nominalpemasukan'],
        tanggalpemasukan: maps[i]['tanggalpemasukan'],
      );
    });
  }

  Future<int> getTotalPemasukan() async {
    final db = await database;
    final result = await db.rawQuery('SELECT SUM(nominalpemasukan) as total FROM $tablePemasukanName');
    return result.isNotEmpty ? result.first['total'] as int : 0;
  }

  // CRUD operations for Pengeluaran table
  Future<int> createPengeluaranEntry(ManageBookPengeluaranEntry entry) async {
    final db = await database;
    return await db.insert(tablePengeluaranName, entry.toMap());
  }

  Future<List<ManageBookPengeluaranEntry>> getPengeluaranEntries() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tablePengeluaranName);
    return List.generate(maps.length, (i) {
      return ManageBookPengeluaranEntry(
        id: maps[i]['id'],
        ketpengeluaran: maps[i]['ketpengeluaran'],
        nominalpengeluaran: maps[i]['nominalpengeluaran'],
        tanggalpengeluaran: maps[i]['tanggalpengeluaran'],
      );
    });
  }

  Future<int> getTotalPengeluaran() async {
    final db = await database;
    final result = await db.rawQuery('SELECT SUM(nominalpengeluaran) as total FROM $tablePengeluaranName');
    return result.isNotEmpty ? result.first['total'] as int : 0;
  }
}



class User {
  int? id;
  String username;
  String email;
  String password;

  User({this.id, required this.email ,required this.username, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email' : email,
      'username': username,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      email: map['email'],
      username: map['username'],
      password: map['password'],
    );
  }
}


class ManageBookPemasukanEntry {
  int? id;
  String ketpemasukan;
  int nominalpemasukan;
  String tanggalpemasukan; 

  ManageBookPemasukanEntry({
    this.id,
    required this.ketpemasukan,
    required this.nominalpemasukan,
    required this.tanggalpemasukan, 
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ketpemasukan': ketpemasukan,
      'nominalpemasukan': nominalpemasukan,
      'tanggalpemasukan': tanggalpemasukan, 
    };
  }
}

class ManageBookPengeluaranEntry {
  int? id;
  String ketpengeluaran;
  int nominalpengeluaran;
  String tanggalpengeluaran; 

  ManageBookPengeluaranEntry({
    this.id,
    required this.ketpengeluaran,
    required this.nominalpengeluaran,
    required this.tanggalpengeluaran, 
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ketpengeluaran': ketpengeluaran,
      'nominalpengeluaran': nominalpengeluaran,
      'tanggalpengeluaran': tanggalpengeluaran, 
    };
  }
}
