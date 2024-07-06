import 'package:Isar/pages/notes_pages.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:Isar/models/note_database.dart';
import 'package:provider/provider.dart';

class BuildTimer extends ChangeNotifier {
  late BuildContext context;
  BuildTimer(this.context); // 建構式，接收BuildContext

  bool isRunning = false;
  bool isCountDown = false;
  Duration duration = Duration();
  Duration saveTime = Duration();
  Duration countDownDuration = Duration(minutes: 1, seconds: 0);
  Timer? timer;

  // 正計時 增加時間
  void _addTime() {
    int addSeconds = isCountDown ? -1 : 1;

    int seconds = duration.inSeconds + addSeconds;
    if (seconds < 0) {
      timer?.cancel();
    } else {
      duration = Duration(seconds: seconds);
      notifyListeners(); // 吹號角 發出通知刷新畫面
      print(duration);
    }
  }

  // 計時函式
  void startCount() {
    isRunning = true;
    // 新增計時器 每隔1秒 呼叫addTime()
    timer = Timer.periodic(Duration(seconds: 1),
        (_) => _addTime()); // 一定要用函式(_)回傳void函式，不能直接呼叫void函式
  }

  // zawarodo 暫停時間(取消計時)
  void stopTimer() {
    isRunning = false;
    timer?.cancel();
    saveTime = duration; // 紀錄時間
    duration = Duration(); // 歸零

    // 新增計時紀錄到資料庫
    String planName = context.read<PlanNameNotifier>().planName; // 取得當前的計畫名稱
    context.read<NoteDataBase>().addNote(planName, saveTime);
    notifyListeners(); // 更新畫面
  }

  //把時間變2位數，顯示數字
  String padLeftTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60)); //取除以60的餘數
    String seconds = twoDigits(duration.inSeconds.remainder(60));

    return minutes + ':' + seconds;
  }

  // 切換開始、停止、取消鈕
  Widget buildButton() {
    return isRunning // 若正在計時，顯示停止鈕
        ? ElevatedButton(
            onPressed: stopTimer,
            child: Text('STOP'),
          )
        : ElevatedButton(
            // 若未計時，顯示開始鈕
            onPressed: startCount,
            child: Text('START'),
          );
  }

  // timerUI
  Widget timerUI(String time) => Container(
        color: Color.fromARGB(255, 245, 239, 223),
        child: SizedBox(
          height: 125,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // 顯示時間
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    time, // 顯示經過padLeftTime()對齊過的時間
                    style: TextStyle(fontSize: 48),
                  ),
                ],
              ),
              buildButton() // 開始、停止、取消鈕
            ],
          ),
        ),
      );
}
