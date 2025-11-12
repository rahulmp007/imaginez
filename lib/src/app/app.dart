import 'package:flutter/material.dart';
import 'package:imaginez/src/core/routing/app_router.dart';

class Imagines extends StatelessWidget {
  const Imagines({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
      // showPerformanceOverlay:true,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
}
