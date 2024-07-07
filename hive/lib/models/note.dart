import 'package:isar/isar.dart';

// this line is needed to generate file
// then run this in terminal: dart run build_runner build
// 讓資料庫可以放進自訂的類別
part 'note.g.dart';

@Collection()
class Note {
  // 自訂的Note類別，裡面有ID、計畫標題、時間長度
  Id id = Isar.autoIncrement; // 每增加1筆資料，ID會自動+1
  late String text; // 稍後才會得到資料的變數，前面要加late
  late int seconds; // 時間長度(存秒數)
}
