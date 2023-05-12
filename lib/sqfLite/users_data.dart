import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:machine_test_kawika_technologies/sqfLite/users.dart';

class UserDatabase {
  static final UserDatabase instance = UserDatabase._init();

  static Database? _database;

  UserDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('users.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
    CREATE TABLE $tableUsers (
    ${UserFields.id} $idType,
  ${UserFields.userName} $textType,
  ${UserFields.userImage} $textType,
  ${UserFields.noOfRepos} $integerType,
  ${UserFields.location} $integerType,
  ${UserFields.blog} $textType,
  ${UserFields.followers} $integerType,
  ${UserFields.following} $integerType
    )
    ''');
  }

  Future<Users> create(Users users) async {
    final db = await instance.database;

    final id = await db.insert(tableUsers, users.toJson());
    return users.copy(id: id);
  }

  Future<Users> readData(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableUsers,
        columns: UserFields.values,
        where: '${UserFields.id} = ?',
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Users.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Users>> readAllItemData() async {
    final db = await instance.database;

    final result = await db.query(tableUsers, orderBy: '${UserFields.id} ASC');

    return result.map((json) => Users.fromJson(json)).toList();
  }

  Future<int> update(Users users) async {
    final db = await instance.database;

    return db.update(
      tableUsers,
      users.toJson(),
      where: '${UserFields.id} = ?',
      whereArgs: [users.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableUsers,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
