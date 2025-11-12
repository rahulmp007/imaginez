import 'package:equatable/equatable.dart';

abstract class PromptEvent extends Equatable {
  const PromptEvent();

  @override
  List<Object?> get props => [];
}

class LoadPrompts extends PromptEvent {
  final String limit;
  const LoadPrompts({required this.limit});

  @override
  List<Object?> get props => [limit];
}

class LoadMorePrompts extends PromptEvent {
  final String page;
  final String limit;

  const LoadMorePrompts({required this.page, required this.limit});

  @override
  List<Object?> get props => [page, limit];
}
