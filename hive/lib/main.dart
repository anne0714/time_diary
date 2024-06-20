import 'package:Isar/models/note_database.dart';
import 'package:Isar/models/timer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/notes_pages.dart';

void main() async {
  // initialize note isar db
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDataBase.initialize();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => NoteDataBase(),
    ),
    ChangeNotifierProvider(
      create: (context) => BuildTimer(context),
    )
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: NotesPage());
  }
}
