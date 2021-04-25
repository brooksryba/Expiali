import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void DatabaseManager() async {
  WidgetsFlutterBinding.ensureInitialized();
// Open the database and store the reference.
  final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'database.db'), onCreate: (db, version) {
    return db.execute(
        "CREATE TABLE messages(id INTEGER PRIMARY KEY, sender TEXT, recipient TEXT, content TEXT, timestamp TEXT, unread INTEGER)");
  }, version: 1);

  Future<void> insertMessage(UserMessage message) async {
    final Database db = await database;
    await db.insert(
      'messages',
      message.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<UserMessage>> messages() async {
    final Database db = await database;

    //Query for all messages
    final List<Map<String, dynamic>> maps = await db.query('messages');

    return List.generate(maps.length, (i) {
      return UserMessage(
        id: maps[i]['id'],
        sender: maps[i]['sender'],
        recipient: maps[i]['recipient'],
        content: maps[i]['content'],
        timestamp: maps[i]['timestamp'],
        unread: maps[i]['unread'],
      );
    });
  }

  Future<void> updateMessage(UserMessage message) async {
    final db = await database;

    await db.update(
      'messages',
      message.toMap(),
      where: "id = ?",
      whereArgs: [message.id],
    );
  }

  Future<void> deleteMessage(int id) async {
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'messages',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  var message1 = UserMessage(
    id: 0,
    sender: "deisumus",
    recipient: "testUser2",
    content: "Hello World!",
    timestamp: "2021-04-01 12:00",
    unread: 0,
  );

  await insertMessage(message1);

  print(await messages());
}

class UserMessage {
  final int id;
  final String sender;
  final String recipient;
  final String content;
  final String timestamp;
  final int unread;

  UserMessage(
      {this.id,
      this.sender,
      this.recipient,
      this.content,
      this.timestamp,
      this.unread});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sender': sender,
      'recipient': recipient,
      'content': content,
      'timestamp': timestamp,
      'unread': unread,
    };
  }

  @override
  String toString() {
    return 'UserMessage{id: $id, sender: $sender, recipient: $recipient, content: $content, timestamp: $timestamp, unread: $unread}';
  }
}

/*



*/
