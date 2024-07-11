import 'package:Isar/pages/notes_pages.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:Isar/models/note_database.dart';
import 'package:provider/provider.dart';

import 'plan_db.dart';

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
      // 更新目標剩餘時間
      _updateGoalTime(addSeconds);
      notifyListeners(); // 吹號角 發出通知刷新畫面
    }
  }

  // 更新目標剩餘時間
  void _updateGoalTime(int addSeconds) {
    final planName = context.read<PlanNotifier>().planName;
    final planDataBase = context.read<PlanDataBase>();
    final plan = planDataBase.getPlanByName(planName);

    // 若計畫有設定目標，且未完成，減少剩餘時間
    if (plan != null && !plan.isDone) {
      plan.leftSecs -= addSeconds;
      if (plan.leftSecs < 0) {
        plan.leftSecs += 60;
        plan.leftMins -= 1;
      }
      if (plan.leftMins < 0) {
        plan.leftMins += 60;
        plan.leftHours -= 1;
      }
      if (plan.leftHours < 0) {
        plan.leftHours = 0;
        plan.leftMins = 0;
        plan.leftSecs = 0;
        plan.isDone = true;
      }
      planDataBase.updatePlan(plan);
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
    String planName = context.read<PlanNotifier>().planName; // 取得當前的計畫名稱
    context.read<NoteDataBase>().addNote(planName, saveTime);
    notifyListeners(); // 更新畫面
  }

  //把時間變2位數，顯示數字
  static String padLeftTime(Duration inputDuration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(inputDuration.inHours); //小時
    String minutes =
        twoDigits(inputDuration.inMinutes.remainder(60)); //取除以60的餘數
    String seconds = twoDigits(inputDuration.inSeconds.remainder(60));
    return hours + ':' + minutes + ':' + seconds;
  }

  // 把整數秒數變duration時間格式
  static String secToPadLeftTime(int seconds) {
    Duration newDuration = Duration(seconds: seconds);
    String padLeftTime = BuildTimer.padLeftTime(newDuration);
    return padLeftTime;
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
