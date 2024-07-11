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
  int secs = 0; // 每日目標秒數
  late int leftHours; // 剩餘時數
  late int leftMins; // 剩餘分鐘數
  int leftSecs = 0; // 剩餘秒數
  bool isDone = false; // 是否完成
  float progress = 0; // 進度百分比
  late int color; // 顏色
}
