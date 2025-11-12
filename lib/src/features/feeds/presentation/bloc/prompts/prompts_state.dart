import 'package:equatable/equatable.dart';
import 'package:imaginez/src/features/feeds/domain/entity/prompt.dart';

abstract class PromptState extends Equatable {
  const PromptState();

  @override
  List<Object?> get props => [];
}

class PromptInitial extends PromptState {}

class PromptLoading extends PromptState {}

class PromptLoaded extends PromptState {
  final List<Prompt> prompts;
  final bool hasMore;
  final int currentPage;

  const PromptLoaded({
    required this.prompts,
    required this.hasMore,
    required this.currentPage,
  });

  PromptLoaded copyWith({
    List<Prompt>? prompts,
    bool? hasMore,
    int? currentPage,
  }) => PromptLoaded(
      prompts: prompts ?? this.prompts,
      hasMore: hasMore ?? this.hasMore,
      currentPage: currentPage ?? this.currentPage,
    );

  @override
  List<Object?> get props => [prompts, hasMore, currentPage];
}

class PromptPaginating extends PromptLoaded {
  const PromptPaginating({
    required super.prompts,
    required super.hasMore,
    required super.currentPage,
  });
}

class PromptPaginationError extends PromptLoaded {
  final String message;

  const PromptPaginationError({
    required super.prompts,
    required super.hasMore,
    required super.currentPage,
    required this.message,
  });

  @override
  List<Object?> get props => [prompts, hasMore, currentPage, message];
}

class PromptError extends PromptState {
  final String message;
  const PromptError(this.message);

  @override
  List<Object?> get props => [message];
}
