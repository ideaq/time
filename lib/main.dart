import 'package:dwyl_app/logging/logging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'blocs/blocs.dart';
import 'presentation/views/views.dart';

// coverage:ignore-start
void main() {
  // Setting global log bloc observer and Lumberdash
  Bloc.observer = GlobalLogBlocObserver();
  putLumberdashToWork(withClients: [ColorizeLumberdash()]);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ItemBloc>(create: (context) => ItemBloc()..add(ItemListStarted())),
        BlocProvider<AppCubit>(create: (context) => AppCubit(isWeb: kIsWeb)),
      ],
      child: const MainApp(),
    ),
  );
}
// coverage:ignore-end

/// The main class of the app.
/// It will create the state manager with `BlocProvider` and make it available along the widget tree.
///
/// The `ItemListStarted` event is instantly spawned when the app starts.
/// This is because we've yet have the need to fetch information from third-party APIs before initializing the app.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 425, name: MOBILE),
          const Breakpoint(start: 426, end: 768, name: TABLET),
          const Breakpoint(start: 769, end: 1024, name: DESKTOP),
          const Breakpoint(start: 1025, end: 1440, name: 'LARGE_DESKTOP'),
          const Breakpoint(start: 1441, end: double.infinity, name: '4K'),
        ],
      ),
    );
  }
}
