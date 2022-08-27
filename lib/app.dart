import 'package:done/assets/theme/theme.dart';
import 'package:done/common/di/service_locator.dart';
import 'package:done/common/services/theme_provider.dart';
import 'package:done/feature/app/models/priority.dart';
import 'package:done/feature/app/models/task.dart';
import 'package:done/feature/main_page/bloc/tasklist_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'feature/app/navigator/navigation_delegate.dart';

class App extends StatefulWidget {
  final bool isDebug;

  const App({
    Key? key,
    required this.isDebug,
  }) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final ServiceLocator locator = ServiceLocator();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TaskListBloc>(
      create: (_) => locator.bloc,
      child: OverlaySupport.global(
        child: ChangeNotifierProvider<NavigationDelegate>.value(
          value: locator.appNavigator.navigationDelegate,
          child: Consumer<NavigationDelegate>(builder: (context, delegate, _) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: widget.isDebug,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: const [
                Locale('en'),
                Locale('ru'),
              ],
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.system,
              routeInformationParser:
                  locator.appNavigator.routeInforamtionParser,
              routerDelegate: delegate,
            );
          }),
        ),
      ),
    );
  }
}
