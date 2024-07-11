import 'package:Isar/models/note_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:Isar/models/note.dart';
import 'package:Isar/models/timer.dart';

import '../models/plan.dart';
import '../models/plan_db.dart';

class PlanNotifier extends ChangeNotifier {
  String _planName = '計畫名稱';

  String get planName => _planName;

  void setPlanName(String newName) {
    _planName = newName;
    notifyListeners();
  }
}

class NotesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Text controller 偵測文字輸入
    final textController = TextEditingController();

    // 存取資料
    void readNotes() {
      context.read<NoteDataBase>().fetchNotes();
      context.read<PlanDataBase>().fetchGoalPlans();
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

    // 有設定目標時數的計畫
    List<Plan> goalPlansList = context.watch<PlanDataBase>().goalPlansList;

    // UI
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
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            children: [
              Icon(Icons.timelapse, size: 20, color: Colors.grey[600]),
              SizedBox(width: 5),
              Text('今日目標',
                  style: TextStyle(fontSize: 20, color: Colors.grey[600])),
            ],
          ),
        ),
        // 有設定目標時數的計畫
        goalPlans(goalPlansList),
        Padding(
          padding: const EdgeInsets.only(left: 16),
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
              SizedBox(width: 393, height: 40, child: pickPlan(context)),
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

  Expanded goalPlans(List<Plan> goalPlansList) {
    return Expanded(
      child: GridView.builder(
          padding: EdgeInsets.only(left: 16, right: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 這裡設置為2，表示雙欄
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 2,
          ),
          itemBuilder: (context, index) {
            // get individual plan
            final plan = goalPlansList[index];
            String remainingTime =
                '${twoDigits(plan.leftHours)}:${twoDigits(plan.leftMins)}:${twoDigits(plan.leftSecs)}';

            /*return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5.0,
              child: InkWell(
                onTap: () {
                  // 处理点击事件
                },
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plan.name + remainingTime,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(blurRadius: 5.0, color: Colors.grey[800]!),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );*/
            // list tile UI
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(plan.color),
              ),
              child: ListTile(
                title: Text(
                  plan.name,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(blurRadius: 5.0, color: Colors.grey[800]!),
                    ],
                  ),
                ),
                subtitle: Text(
                  remainingTime,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(blurRadius: 5.0, color: Colors.grey[800]!),
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: goalPlansList.length),
    );
  }

  // 選擇計畫名稱
  TextButton pickPlan(BuildContext context) {
    return TextButton(
        child: planNameTimer(),
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
            context.read<PlanNotifier>().setPlanName(selectedPlanName);
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

  // 把目標時間轉換成00:00:00格式
  String twoDigits(int n) => n.toString().padLeft(2, '0');
}
