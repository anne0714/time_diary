import 'package:Isar/models/note_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Isar/models/note.dart';
import 'package:Isar/models/timer.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  // Text controller 偵測文字輸入
  final textController = TextEditingController();

  @override
  // 在介面初始載入時就讀取資料
  void initState() {
    super.initState();

    readNotes();
  }

  // create a note
  void createNote() {
    // 顯示對話框
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
              ),
              actions: [
                // create buttom
                MaterialButton(
                  onPressed: () {
                    // add to db
                    context.read<NoteDataBase>().addNote(textController.text);

                    // clear controller 每次送出資料後，把文字輸入框清掉
                    textController.clear();

                    // pop dialog box 關閉對話框
                    Navigator.pop(context);
                  },
                  child: const Text("create"),
                )
              ],
            ));
  }

  // 存取資料
  void readNotes() {
    context.read<NoteDataBase>().fetchNotes();
  }

  // 更新資料
  void updateNote(Note note) {
    // 文字框內預填好 要更新的資料內容
    textController.text = note.text;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Updata Note"),
              content: TextField(
                controller: textController,
              ),
              actions: [
                // updata buttom
                MaterialButton(
                  onPressed: () {
                    // updata note in db
                    context
                        .read<NoteDataBase>()
                        .updateNote(note.id, textController.text);
                    // clear controller
                    textController.clear();
                    // pop dialog box
                    Navigator.pop(context);
                  },
                  child: const Text("Update"),
                )
              ],
            ));
  }

  // delete a note
  void deleteNote(int id) {
    context.read<NoteDataBase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    // note database
    final noteDatabase = context.watch<NoteDataBase>();

    // create the list of notes
    List<Note> notesList = noteDatabase.notesList;

    // noteslist UI 用一個ListView顯示資料列表
    Widget notesListUI() => Expanded(
          child: SizedBox(
            height: 100,
            child: ListView.builder(
                itemCount: notesList.length,
                itemBuilder: (context, index) {
                  // get individual note
                  final note = notesList[index];

                  // list tile UI
                  return ListTile(
                    title: Text(
                      note.text,
                      style: TextStyle(fontSize: 28),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // edit buttom
                        IconButton(
                            onPressed: () => updateNote(note),
                            icon: const Icon(Icons.edit)),

                        // delete buttom
                        IconButton(
                            onPressed: () => deleteNote(note.id),
                            icon: const Icon(Icons.delete))
                      ],
                    ),
                  );
                }),
          ),
        );

    // BuildTimer物件 建立時要加上 context.watch 監聽BuildTimer的變化！
    BuildTimer buildTimer = context.watch<BuildTimer>();

    // UI
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 228, 85, 19),
      ),
      // 新增紀錄按鈕
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: Icon(Icons.add),
      ),
      body: Column(children: [
        notesListUI(),
        buildTimer.padLeftTime(), // 計時器UI
      ]),
    );
  }
}
