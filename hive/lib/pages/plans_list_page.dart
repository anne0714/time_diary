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
                title: Text("更新計畫名稱"),
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
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("新增計畫"),
                content: TextField(
                  controller: textController,
                ),
                actions: [
                  // add buttom
                  MaterialButton(
                    onPressed: () {
                      // add Plan in db
                      context.read<PlanDataBase>().addPlan(textController.text);
                      // clear controller
                      textController.clear();
                      // pop dialog box
                      Navigator.pop(context);
                    },
                    child: const Text("確定"),
                  )
                ],
              ));
    }

    // UI
    return Scaffold(
        appBar: AppBar(
          title: const Text("計畫列表"),
        ),
        // 新增計畫按鈕
        floatingActionButton: FloatingActionButton(
          onPressed: addPlan,
          child: Icon(Icons.add),
        ),
        body: Column(
          children: [
            Expanded(
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                    itemCount: plansList.length,
                    itemBuilder: (context, index) {
                      // get individual Plan
                      final plan = plansList[index];

                      // list tile UI
                      return ListTile(
                        // 計畫名稱
                        title: Text(
                          plan.name,
                          style: TextStyle(fontSize: 18),
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
                                icon: const Icon(Icons.edit)),

                            // delete buttom
                            IconButton(
                                onPressed: () => deletePlan(plan.id),
                                icon: const Icon(Icons.delete))
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ],
        ));
  }
}
