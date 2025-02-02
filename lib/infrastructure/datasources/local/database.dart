import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:ezycourse/main.dart';
import 'package:ezycourse/utils/color_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/entities/feed.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'feed_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS Feed(
        id INTEGER PRIMARY KEY,
        school_id INTEGER,
        user_id INTEGER,
        course_id INTEGER,
        community_id INTEGER,
        group_id INTEGER,
        feed_txt TEXT,
        status TEXT,
        file_type TEXT,
        like_count INTEGER,
        comment_count INTEGER,
        share_count INTEGER,
        share_id INTEGER,
        feed_privacy TEXT,
        is_background INTEGER,
        bg_color TEXT,
        space_id INTEGER,
        publish_date TEXT,
        name TEXT,
        likeType TEXT,
        follow TEXT,
        like TEXT
      )
    ''');
  }

  Future<void> resetDatabase() async {
    Database db = await database;
    await db.execute('DROP TABLE IF EXISTS Feed');
    Get.snackbar("Database", "Database cleared successfully",
        backgroundColor: ColorConfig.greenColor, colorText: ColorConfig.whiteColor, snackPosition: SnackPosition.BOTTOM,
      );
    await _onCreate(db, 1);
  }

  Future<int> insertFeed(Feed feed) async {
    Database db = await database;
    return await db.insert('Feed', feed.toJson());
  }

  Future<List<Feed>> getFeeds() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('Feed');

    var feeds = maps.map((map) {
      Map<String, dynamic> updatedMap = Map.from(map);

      if (updatedMap['likeType'] is Uint8List) {
        updatedMap['likeType'] = jsonDecode(utf8.decode(updatedMap['likeType']));
      }
      if (updatedMap['like'] is String) {
        updatedMap['like'] = jsonDecode(updatedMap['like']);
      }

      return Feed.fromJson(updatedMap);
    }).toList();

    feeds.sort((a, b) => DateTime.parse(b.publishDate ?? "").compareTo(DateTime.parse(a.publishDate ?? "")));
    return feeds;
  }

}