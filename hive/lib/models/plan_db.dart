import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:Isar/models/plan.dart';
import 'package:path_provider/path_provider.dart';

class PlanDataBase extends ChangeNotifier {
  // 監測有沒有改變
  static late Isar isar; // 資料庫類別

  // Initialize Database
  static Future<void> initialize() async {
    final dir =
        await getApplicationDocumentsDirectory(); // 要在yaml中引入path_provider: 抓資料存放的位置
    isar = await Isar.open([PlanSchema],
        directory: dir.path,
        name: 'plan_database'); // 不同的資料庫要用不同名稱區分，Isar.open()才不會打開同一個資料庫
  }

  // 存放計畫的列表
  final List<Plan> plansList = [];

  // Create
  Future<void> addPlan(
      String planName, bool isGoal, int hours, int mins, Color color) async {
    // 新增計畫物件
    final newPlan = Plan()..name = planName;
    // 是否有目標執行時間
    newPlan.isGoal = isGoal;
    newPlan.hours = hours;
    newPlan.mins = mins;
    newPlan.color = color.value;
    // save to db 把newPlan寫進isar資料庫中的plans表
    await isar.writeTxn(() => isar.plans.put(newPlan));

    // re-read from db
    await fetchPlans();
  }

  // Read
  Future<void> fetchPlans() async {
    // 找到所有plans中的資料，傳入fetchplans
    List<Plan> fetchplans = await isar.plans.where().findAll();
    plansList.clear();
    // 清空資料、新增資料至列表
    plansList.addAll(fetchplans);
    notifyListeners(); // 讀取資料後刷新螢幕
  }

  // Update 改變計畫名稱
  Future<void> updatePlan(int id, String newPlanName) async {
    // 用id找到現有的Plan
    final existingPlan = await isar.plans.get(id);
    if (existingPlan != null) {
      // 更新plans的資料
      existingPlan.name = newPlanName;
      // 放回資料庫中
      await isar.writeTxn(() => isar.plans.put(existingPlan));
      // 更新完確認一次資料
      await fetchPlans();
    }
  }

  // Delete 刪除計畫
  Future<void> deletePlan(int id) async {
    await isar.writeTxn(() => isar.plans.delete(id));
    await fetchPlans();
  }
}
