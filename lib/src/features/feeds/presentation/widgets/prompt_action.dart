import 'package:flutter/material.dart';

class PromptActionWidget extends StatelessWidget {
  final Widget icon;
  final Widget? subtitle;
  const PromptActionWidget({super.key, required this.icon, this.subtitle});

  @override
  Widget build(BuildContext context) => Column(children: [icon, subtitle ?? const SizedBox.shrink()]);
}
