
import 'package:done/assets/theme/theme.dart';
import 'package:done/common/di/service_locator.dart';
import 'package:done/common/services/theme_provider.dart';
import 'package:done/feature/app/models/priority.dart';
import 'package:done/feature/app/models/task.dart';
import 'package:done/feature/main_page/bloc/tasklist_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initLogger();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(PriorityAdapter());
  await Hive.openBox<Task>('tasks');
  runApp(
    const App(),
  );
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final ServiceLocator locator = ServiceLocator();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskListBloc>(
      create: (_) => locator.bloc,
      child: ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: OverlaySupport.global(
          child: Consumer<ThemeProvider>(
            builder: (context, ThemeProvider theme, child) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: const [
                  Locale('en'),
                  Locale('ru'),
                ],
                theme: theme.isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
                routeInformationParser: locator.appNavigator.routeInforamtionParser,
                routerDelegate: locator.appNavigator.navigationDelegate,
              );
            },
          ),
        ),
      ),
    );
  }
}
