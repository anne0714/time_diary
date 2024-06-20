import 'package:Isar/models/note.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NoteDataBase extends ChangeNotifier {
  // 監測有沒有改變
  static late Isar isar; // 資料庫類別

  // Initialize Database
  static Future<void> initialize() async {
    final dir =
        await getApplicationDocumentsDirectory(); // 要在yaml中引入path_provider: 抓資料存放的位置
    isar = await Isar.open([NoteSchema],
        directory: dir.path); // NoteSchema 從 note.g.dart中自動生成[自訂類別名稱]Schema
  }

  // list of notes
  final List<Note> notesList = [];

  // Create - a note and save to db
  Future<void> addNote(String textFromUser) async {
    // create a new note object
    final newNote = Note()..text = textFromUser;

    // save to db 把newNote寫進isar資料庫中的notes表
    await isar.writeTxn(() => isar.notes.put(newNote));

    // re-read from db
    await fetchNotes();
  }

  // Read - notes from db
  Future<void> fetchNotes() async {
    // 找到所有notes中的資料，傳入fetchNotes
    List<Note> fetchNotes = await isar.notes.where().findAll();
    notesList.clear();
    // 清空資料、新增資料至列表
    notesList.addAll(fetchNotes);
    notifyListeners(); // 讀取資料後刷新螢幕
  }

  // Update - a note in db
  Future<void> updateNote(int id, String newText) async {
    // 用id找到現有的Note
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      // 更新Notes的資料
      existingNote.text = newText;
      // 放回資料庫中
      await isar.writeTxn(() => isar.notes.put(existingNote));
      // 更新完確認一次資料
      await fetchNotes();
    }
  }

  // Delete - a note in db
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}
