import 'package:done/assets/theme/theme.dart';
import 'package:done/common/di/di_container.dart';
import 'package:done/common/routes/app_router.dart';
import 'package:done/common/services/navigation_service.dart';
import 'package:done/common/services/remote_config_service.dart';
import 'package:done/feature/main_page/task_list_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;


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
  final RemoteConfigService remoteConfig=RemoteConfigService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<RemoteConfigService>(create: (_)=> remoteConfig),
        Provider<NavigationService>(create: (_) => navigationService),
        ...DIContainer.instance.providers,
      ],
      child: OverlaySupport.global(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigationService.navigationKey,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          // localizationsDelegates: const [
          //   GlobalMaterialLocalizations.delegate,
          //   GlobalWidgetsLocalizations.delegate,
          //   GlobalCupertinoLocalizations.delegate,
          //   AppLocalizations.delegate(),
          // ],
          supportedLocales: const [
            Locale('en'),
            Locale('ru'),
          ],
          theme: AppTheme.lightTheme,
          onGenerateRoute: AppRouter.generateRoute,
          home: const TaskListScreen(),
          //initialRoute: AppRouter.mainScreen,
        ),
      ),
    );
  }
}
