import 'package:flutter/material.dart';
import 'package:imir_app/components/animation_logo.dart';
import 'package:imir_app/components/splash_video_background.dart';
import 'package:imir_app/models/app_state_manager.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Provider.of<AppStateManager>(context, listen: false).initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            VideoBackground(),
            AnimationLogo(width: 100, height: 100,),
          ],
        )
    );
  }
}
