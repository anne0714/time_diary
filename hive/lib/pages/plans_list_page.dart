import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/plan.dart';
import '../models/plan_db.dart';

class PlansListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Plan database
    final planDatabase = context.watch<PlanDataBase>();
    // create the list of Plans
    List<Plan> plansList = planDatabase.plansList;

    // 文字輸入框 用來改計畫名稱
    final textController = TextEditingController();

    // 建立頁面時 初始化存取資料
    void readPlans() {
      context.read<PlanDataBase>().fetchPlans();
    }

    readPlans();

    // 更新資料
    void updatePlan(Plan Plan) {
      // 文字框內預填好 要更新的資料內容
      textController.text = Plan.name;
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("更改計畫名稱"),
                content: TextField(
                  controller: textController,
                ),
                actions: [
                  // updata buttom
                  MaterialButton(
                    onPressed: () {
                      // updata Plan in db
                      context
                          .read<PlanDataBase>()
                          .updatePlan(Plan.id, textController.text);
                      // clear controller
                      textController.clear();
                      // pop dialog box
                      Navigator.pop(context);
                    },
                    child: const Text("確認"),
                  )
                ],
              ));
    }

    // delete plan function
    void deletePlan(int id) {
      context.read<PlanDataBase>().deletePlan(id);
    }

    // 新增計畫
    void addPlan() {
      textController.clear();
      Navigator.pushNamed(context, '/addplanpage');
    }

    // UI
    return Scaffold(
        appBar: AppBar(
          title: const Text("計畫列表"),
          backgroundColor: Colors.white,
        ),
        // 新增計畫按鈕
        floatingActionButton: FloatingActionButton(
          onPressed: addPlan,
          child: Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.list_rounded, size: 20, color: Colors.grey[600]),
                  SizedBox(width: 5),
                  Text('請選擇1項計畫',
                      style: TextStyle(fontSize: 20, color: Colors.grey[600])),
                ],
              ),
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10),
                      itemCount: plansList.length,
                      itemBuilder: (context, index) {
                        // get individual Plan
                        final plan = plansList[index];

                        // list tile UI
                        return Container(
                          // 每個list背景顏色用plan.color決定 color不能和boxdecoration同時用
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(plan.color),
                            /*border:
                                Border.all(color: Color(plan.color), width: 3),*/
                          ),
                          child: ListTile(
                            dense: true,
                            // 計畫名稱
                            title: Text(
                              plan.name +
                                  plan.hours.toString() +
                                  '小時' +
                                  plan.mins.toString() +
                                  '分 ',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 5.0,
                                    color: Colors.grey[800]!,
                                    offset: Offset(0.0, 1.0),
                                  ),
                                ],
                              ),
                            ),
                            // 點擊選取該計畫名稱，返回紀錄頁面
                            onTap: () {
                              Navigator.pop(context, plan.name);
                            },
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // edit buttom
                                IconButton(
                                    onPressed: () => updatePlan(plan),
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    )),

                                // delete buttom
                                IconButton(
                                    onPressed: () => deletePlan(plan.id),
                                    icon: const Icon(Icons.delete,
                                        color: Colors.white))
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ],
          ),
        ));
  }
}
