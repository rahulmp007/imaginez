import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imaginez/src/features/feeds/domain/usecases/get_prompts.dart';
import 'package:imaginez/src/features/feeds/presentation/bloc/prompts/prompts_bloc.dart';
import 'package:imaginez/src/features/feeds/presentation/bloc/prompts/prompts_event.dart';
import 'package:imaginez/src/features/feeds/presentation/widgets/prompts_list.dart';
import 'package:imaginez/src/injection/service_locator.dart';

class PromptsFeed extends StatefulWidget {
  const PromptsFeed({super.key});

  @override
  State<PromptsFeed> createState() => _PromptsFeedState();
}

class _PromptsFeedState extends State<PromptsFeed> {
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) =>
        PromptBloc(getPrompts: sl<GetPrompts>())
          ..add(const LoadPrompts(limit: '10')),
    child: Builder(
      builder: (context) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<PromptBloc>().add(const LoadPrompts(limit: '10'));
            },
            child: const SafeArea(child: PromptsList()),
          ),
        );
      },
    ),
  );
}
