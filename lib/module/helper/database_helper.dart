import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  DataBaseHelper._();

  static final DataBaseHelper databaseHelper = DataBaseHelper._();

  Database? db;

  Future<Database?> initDB() async {
    String path = await getDatabasesPath();
    String databasePath = join(path, "RecipeDB.db");

    print(databasePath);

    db = await openDatabase(databasePath, version: 1,
        onCreate: (Database db, _) async {
      String sql =
          "CREATE TABLE IF NOT EXISTS Recipe (id INTEGER PRIMARY KEY AUTOINCREMENT, recipename TEXT, recipe TEXT);";

      await db.execute(sql);
    });

    return db;
  }

  Future<void> insertData(String recipename, String recipe) async {
    db = await initDB();

    String sql = "INSERT INTO Recipe(recipename,recipe) VALUES(?,?)";
    List args = [recipename, recipe];

    await db!.rawInsert(sql, args);
  }

  Future<List<Map<String, Object?>>> fetchAllData() async {
    db = await initDB();

    String sql = "SELECT * FROM Recipe";

    List<Map<String, Object?>> fetchedData = await db!.rawQuery(sql);

    return fetchedData;
  }

  Future<void> deleteData({required String recipe}) async {
    db = await initDB();

    String sql = "DELETE FROM Recipe WHERE recipe = ?";
    List values = [recipe];

    await db!.rawDelete(sql, values);
  }
}
