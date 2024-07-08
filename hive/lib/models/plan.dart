import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

// 自動產生的檔案，Isar會自動創建資料庫
// 在terminal執行指令後會創建： dart run build_runner build
part 'plan.g.dart';

@Collection()
class Plan {
  // 自訂的計畫類別，裡面只有ID、文字兩種屬性
  Id id = Isar.autoIncrement; // 每增加1筆資料，ID會自動+1
  late String name; // 稍後才會得到資料的變數，前面要加late
  late bool isGoal; // 是否有設定目標
  late int hours; // 每日目標時數
  late int mins; // 每日目標分鐘數
  late Color color; // 顏色
}
