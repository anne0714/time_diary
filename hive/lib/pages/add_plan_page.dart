import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/plan_db.dart';

class AddPlanPage extends StatefulWidget {
  const AddPlanPage({Key? key}) : super(key: key);
  @override
  _AddPlanPageState createState() => _AddPlanPageState();
}

class _AddPlanPageState extends State<AddPlanPage> {
  late FocusNode myFocusNode;

  @override
  // 覆蓋AddPlanPage()的初始化方法
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  bool isGoal = false;
  Duration goalDuration = Duration();
  final TextEditingController textController = TextEditingController();

  void selectTimeLength(BuildContext context) {
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
                    setState(() {
                      goalDuration = duration;
                      isGoal = true;
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("新增計畫"),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("計畫名稱"),
            TextField(
              // 提示輸入文字
              decoration: new InputDecoration(
                  hintText: "請輸入計畫名稱",
                  hintStyle: TextStyle(color: Colors.grey[500])),
              focusNode: myFocusNode,
              controller: textController,
            ),
            SizedBox(height: 10),
            GoalSwitch(
              isGoal: isGoal,
              onChanged: (value) {
                // 如果不勾選每日目標，清空時間長度
                if (value == false) {
                  setState(() {
                    isGoal = value;
                    goalDuration = Duration();
                  });
                } else
                  setState(() {
                    isGoal = value;
                    selectTimeLength(context);
                  });
              },
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  goalDuration.inHours.toString() +
                      '小時' +
                      (goalDuration.inMinutes % 60).toString() +
                      '分',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                    onPressed: () {
                      selectTimeLength(context);
                    },
                    child: Text('修改時長')),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                int hours = goalDuration.inHours;
                int mins = goalDuration.inMinutes % 60;
                context
                    .read<PlanDataBase>()
                    .addPlan(textController.text, isGoal, hours, mins);
                textController.clear();
                Navigator.pop(context);
              },
              child: const Text("確定"),
            ),
          ],
        ),
      ),
    );
  }
}

class GoalSwitch extends StatelessWidget {
  final bool isGoal;
  final ValueChanged<bool> onChanged;

  GoalSwitch({required this.isGoal, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("每日目標"),
        SizedBox(width: 10),
        Switch(
          value: isGoal,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
