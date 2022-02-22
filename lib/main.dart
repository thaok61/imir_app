import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:imir_app/models/app_state_manager.dart';
import 'package:imir_app/models/music_state_manager.dart';
import 'package:imir_app/network/music_dao.dart';
import 'package:imir_app/screens/home_screen.dart';
import 'package:imir_app/screens/music_list_screen.dart';
import 'package:imir_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appStateManager = AppStateManager();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => _appStateManager),
        ChangeNotifierProvider(create: (_) => MusicStateManager()),
        Provider<MusicDao>(
          create: (_) => MusicDao(),
          lazy: false,
        )
      ],
      child: Consumer<AppStateManager>(
        builder: (context, appStateManager, child) {
          Widget widget;
          if (appStateManager.isInitialized) {
            widget = HomeScreen();
          } else {
            widget = SplashScreen();
          }
          return MaterialApp(
            title: 'IMIR',
            theme: ThemeData(),
            home: widget,
          );
        },
      ),
    );
  }
}
