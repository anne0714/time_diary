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
  Color color = Color.fromARGB(255, 255, 159, 159);
  IconData icon = Icons.circle_rounded;

  void selectTimeLength(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Container(
          height: 240,
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('計畫每日的目標時長',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none)),
                    CupertinoButton(
                        child: Text('確定'),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
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
        // 用SingleChildScrollView包裝Column，鍵盤彈出來的時候畫面不會溢出，因為畫面可以捲動
        child: SingleChildScrollView(
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
              // 顏色選擇
              PickColor(
                // selectedColor為PickColor傳回的顏色變數，再存回color中
                onColorSelected: (selectedColor) {
                  setState(() {
                    color = selectedColor;
                  });
                },
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      int hours = goalDuration.inHours;
                      int mins = goalDuration.inMinutes % 60;
                      context.read<PlanDataBase>().addPlan(
                          textController.text, isGoal, hours, mins, color);
                      textController.clear();
                      Navigator.pop(context);
                    },
                    child: const Text("確定"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 勾選是否為每日目標
class GoalSwitch extends StatelessWidget {
  final bool isGoal;
  final ValueChanged<bool> onChanged;

  GoalSwitch({required this.isGoal, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("每日執行目標"),
        SizedBox(width: 10),
        Switch(
          value: isGoal,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

// 選擇計畫的顏色
class PickColor extends StatefulWidget {
  // 回調函數，傳入父組件顏色變數，當選擇顏色時，會呼叫此函式傳回選擇的顏色
  final ValueChanged<Color> onColorSelected;

  const PickColor({Key? key, required this.onColorSelected}) : super(key: key);

  @override
  State<PickColor> createState() => _PickColorState();
}

class _PickColorState extends State<PickColor> {
  int selectedIndex = 0; // 初始化為選擇紅色

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      Color.fromARGB(255, 255, 159, 159),
      Color.fromARGB(255, 183, 233, 103),
      Color.fromARGB(255, 136, 195, 243),
      Color.fromARGB(255, 253, 204, 69),
      Color.fromARGB(255, 250, 147, 87),
    ];
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
                widget.onColorSelected(colors[index]);
              });
            },
            child: Container(
                width: 40,
                height: 40,
                child: selectedIndex == index
                    ? Icon(
                        Icons.check_circle_rounded,
                        color: colors[index],
                        size: 30,
                      )
                    : Icon(
                        Icons.circle_rounded,
                        color: colors[index],
                        size: 30,
                      ))),
      ),
    );
  }
}
