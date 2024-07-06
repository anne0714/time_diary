import 'package:Isar/models/note_database.dart';
import 'package:Isar/models/timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/plan_db.dart';
import 'pages/notes_pages.dart';
import 'pages/plans_list_page.dart';

void main() async {
  // initialize note isar db
  WidgetsFlutterBinding.ensureInitialized();
  await PlanDataBase.initialize();
  await NoteDataBase.initialize();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => NoteDataBase(),
    ),
    ChangeNotifierProvider(
      create: (context) => PlanDataBase(),
    ),
    ChangeNotifierProvider(
      create: (context) => PlanNameNotifier(),
    ),
    ChangeNotifierProvider(
      create: (context) => BuildTimer(context),
    ),
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesPage(),
      routes: {
        '/planslistpage': (context) => PlansListPage(),
        '/notespage': (context) => NotesPage()
      },
    );
  }
}
