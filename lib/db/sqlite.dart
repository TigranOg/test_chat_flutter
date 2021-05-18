import 'package:chat_app/db/model/chat_latest_timestamp.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteDB {
  static final SqliteDB instance = SqliteDB._init();

  static Database _database;

  SqliteDB._init();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB('chat.db');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(ChatLatestTimestamp.createQuery);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  //CRUD queries goes here
  Future<List<ChatLatestTimestamp>> readAllChatLatestTimestamp() async {
    final db = await instance.database;

    final orderBy = '${ChatLatestTimestamp.timestampField} ASC';

    final result = await db.query(ChatLatestTimestamp.tableName, orderBy: orderBy);

    return result.map((m) => ChatLatestTimestamp.fromMap(m)).toList();
  }

  Future<ChatLatestTimestamp> readChatLatestTimestamp(String chatId) async {
    final db = await instance.database;

    final maps = await db.query(
      ChatLatestTimestamp.tableName,
      columns: ChatLatestTimestamp.values,
      where: '${ChatLatestTimestamp.chatGroupIdField} = ?',
      whereArgs: [chatId],
    );

    if (maps.isNotEmpty) {
      return ChatLatestTimestamp.fromMap(maps.first);
    } else if (maps.isEmpty) {
      return ChatLatestTimestamp(chatId, 0);
    } else {
      throw Exception('ChatId $chatId not found');
    }
  }

  Future createOrReplace(ChatLatestTimestamp chatLatestTimestamp) async {
    final db = await instance.database;

    int resDel = await delete(chatLatestTimestamp.chatGroupId);
    int res = await db.insert(ChatLatestTimestamp.tableName, chatLatestTimestamp.toMap());
    print('TEST TEST $res');
  }

  Future<int> delete(String chatId) async {
    final db = await instance.database;

    return await db.delete(
      ChatLatestTimestamp.tableName,
      where: '${ChatLatestTimestamp.chatGroupIdField} = ?',
      whereArgs: [chatId],
    );
  }

}
