import 'package:done/assets/theme/theme.dart';
import 'package:done/common/di/di_container.dart';
import 'package:done/common/routes/app_router.dart';
import 'package:done/common/services/navigation_service.dart';
import 'package:done/common/services/remote_config_service.dart';
import 'package:done/common/services/theme_provider.dart';
import 'package:done/feature/main_page/bloc/tasklist_bloc.dart';
import 'package:done/feature/main_page/task_list_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

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
  final NavigationService navigationService = NavigationService();
  final RemoteConfigService remoteConfig = RemoteConfigService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        Provider<RemoteConfigService>(create: (_) => remoteConfig),
        Provider<NavigationService>(create: (_) => navigationService),
        BlocProvider<TaskListBloc>(
          create: (_) =>
              TaskListBloc(taskRepository: DIContainer.instance.taskRepository)
                ..add(const GetListEvent()),
        ),
        ...DIContainer.instance.providers,
      ],
      child: OverlaySupport.global(
        child: Consumer<ThemeProvider>(
          builder: (context, ThemeProvider theme, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              navigatorKey: navigationService.navigationKey,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: const [
                Locale('en'),
                Locale('ru'),
              ],
              theme:
                  theme.isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
              onGenerateRoute: AppRouter.generateRoute,
              home: const TaskListScreen(),
              //initialRoute: AppRouter.mainScreen,
            );
          },
        ),
      ),
    );
  }
}
