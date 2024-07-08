import 'package:Isar/models/note_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:Isar/models/note.dart';
import 'package:Isar/models/timer.dart';

class PlanNotifier extends ChangeNotifier {
  String _planName = '計畫名稱';

  String get planName => _planName;

  void setPlanName(String newName) {
    _planName = newName;
    notifyListeners();
  }

  // 目標計畫名稱
  String _planNameGoal = '計畫名稱';

  String get planNameGoal => _planNameGoal;

  void setPlanNameGoal(String newName) {
    _planNameGoal = newName;
    notifyListeners();
  }

  // 目標執行時間長度
  Duration _duration = Duration();
  Duration get duration => _duration;

  void setDuration(Duration newDuration) {
    _duration = newDuration;
    notifyListeners();
  }
}

class NotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 監聽計畫名稱
    final planNameNotifier = context.watch<PlanNotifier>();
    Duration goalDuration = planNameNotifier.duration;
    // Text controller 偵測文字輸入
    final textController = TextEditingController();

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

    // 在介面初始載入時就讀取資料
    readNotes();

    // note database
    final noteDatabase = context.watch<NoteDataBase>();

    // create the list of notes
    List<Note> notesList = noteDatabase.notesList;

    // BuildTimer計時器物件 建立時要加上 context.watch 監聽BuildTimer的變化！
    // BuildTimer buildTimer = context.watch<BuildTimer>();

    // UI
    // 選擇時間長度
    void selectTimeLength() {
      showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return Container(
                height: 200,
                color: Colors.white,
                child: Column(
                  children: [
                    Expanded(
                      child: CupertinoTimerPicker(
                          mode: CupertinoTimerPickerMode.hm,
                          initialTimerDuration: goalDuration,
                          // duration為選擇後的時間長度
                          onTimerDurationChanged: (Duration duration) {
                            context.read<PlanNotifier>().setDuration(duration);
                          }),
                    )
                  ],
                ));
          });
    }

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
                      // 計畫名稱 + 紀錄時間
                      '${note.text} ${BuildTimer.secToPadLeftTime(note.seconds)}',
                      style: TextStyle(fontSize: 18),
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

    // 頁面UI
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '時間日記',
          style: TextStyle(
              fontSize: 30,
              color: Color.fromARGB(255, 61, 61, 61),
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 目標執行時間
            pickPlan(context, 'goal'),
            Text(
                '${goalDuration.inHours}小時${goalDuration.inMinutes % 60}分${goalDuration.inSeconds % 60}秒',
                style: TextStyle(fontSize: 40)),
            ElevatedButton(
                onPressed: selectTimeLength, child: Text('選擇目標執行時間')),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 16),
          child: Row(
            children: [
              Icon(Icons.access_time_rounded,
                  size: 20, color: Colors.grey[600]),
              SizedBox(width: 5),
              Text('最近的紀錄',
                  style: TextStyle(fontSize: 20, color: Colors.grey[600])),
            ],
          ),
        ),
        notesListUI(),
        // 正計時
        Container(
          padding: const EdgeInsets.only(top: 10),
          color: const Color.fromARGB(255, 245, 239, 223),
          child:
              // 選擇計畫名稱
              SizedBox(
                  width: 393, height: 40, child: pickPlan(context, 'timer')),
        ),
        // 計時器UI(開始、停止鍵、時間顯示)
        Consumer<BuildTimer>(
          builder: (context, buildTimer, child) {
            return buildTimer
                .timerUI(BuildTimer.padLeftTime(buildTimer.duration));
          },
        )
      ]),
    );
  }

  // 選擇計畫名稱 用usefor判斷是選擇計時器的計畫，還是目標執行時間的計畫
  TextButton pickPlan(BuildContext context, String usefor) {
    return TextButton(
        child: usefor == 'timer' ? planNameTimer() : planNameGoal(),
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            foregroundColor: Colors.grey[800],
            textStyle: TextStyle(fontSize: 20.0)),
        // 按鈕按下後去計劃列表頁面
        onPressed: () async {
          // 使用 Navigator.push 傳遞 context 讀取選中的計畫名稱
          final selectedPlanName =
              await Navigator.pushNamed(context, '/planslistpage');
          if (selectedPlanName != null && selectedPlanName is String) {
            usefor == 'timer'
                ? context.read<PlanNotifier>().setPlanName(selectedPlanName)
                : context
                    .read<PlanNotifier>()
                    .setPlanNameGoal(selectedPlanName);
          }
        });
  }

  Selector<PlanNotifier, String> planNameTimer() {
    return Selector<PlanNotifier, String>(
        selector: (context, planNameNotifier) => planNameNotifier.planName,
        builder: (context, planName, child) {
          // 顯示計畫名稱
          return Text(
            planName,
          );
        });
  }

  Selector<PlanNotifier, String> planNameGoal() {
    return Selector<PlanNotifier, String>(
        selector: (context, planNameNotifier) => planNameNotifier.planNameGoal,
        builder: (context, planName, child) {
          // 顯示計畫名稱
          return Text(
            planName,
          );
        });
  }
}
