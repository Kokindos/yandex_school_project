import 'package:done/app.dart';
import 'package:done/feature/app/models/priority.dart';
import 'package:done/feature/app/models/task.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'common/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initLogger();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCgLq5h9WYeWRoAJs8VRyFxy5wDaHjcQMk",
          projectId: "done2-943f0",
          messagingSenderId: "887278312984",
          appId: "1:887278312984:web:7fbe39b366e45faf6dad6d"),
    );
  } else {
    await Firebase.initializeApp();
  }
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(PriorityAdapter());
  await Hive.openBox<Task>('tasks');
  runApp(
    const App(
      isDebug: false,
    ),
  );
}
