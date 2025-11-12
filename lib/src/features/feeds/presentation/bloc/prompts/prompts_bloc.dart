import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imaginez/src/features/feeds/domain/usecases/get_prompts.dart';
import 'package:imaginez/src/features/feeds/presentation/bloc/prompts/prompts_event.dart';
import 'package:imaginez/src/features/feeds/presentation/bloc/prompts/prompts_state.dart';

class PromptBloc extends Bloc<PromptEvent, PromptState> {
  final GetPrompts getPrompts;

  PromptBloc({required this.getPrompts}) : super(PromptInitial()) {
    on<LoadPrompts>(_onFetchInitial);
    on<LoadMorePrompts>(_onFetchNextPage);
  }

  Future<void> _onFetchInitial(
    LoadPrompts event,
    Emitter<PromptState> emit,
  ) async {
    emit(PromptLoading());

    final result = await getPrompts(page: '1', limit: event.limit);

    result.fold((failure) => emit(PromptError(failure.message)), (prompts) {
      final hasMore = prompts.isNotEmpty;
      emit(PromptLoaded(prompts: prompts, hasMore: hasMore, currentPage: 1));
    });
  }

  Future<void> _onFetchNextPage(
    LoadMorePrompts event,
    Emitter<PromptState> emit,
  ) async {
    final currentState = state;

    if (currentState is PromptLoaded && currentState.hasMore) {
      emit(
        PromptPaginating(
          prompts: currentState.prompts,
          hasMore: currentState.hasMore,
          currentPage: currentState.currentPage,
        ),
      );

      final result = await getPrompts(page: event.page, limit: event.limit);

      result.fold(
        (failure) {
          emit(
            PromptPaginationError(
              prompts: currentState.prompts,
              hasMore: currentState.hasMore,
              currentPage: currentState.currentPage,
              message: failure.message,
            ),
          );
        },
        (newPrompts) {
          final updatedList = List.of(currentState.prompts)..addAll(newPrompts);
          final hasMore = newPrompts.isNotEmpty;

          emit(
            PromptLoaded(
              prompts: updatedList,
              hasMore: hasMore,
              currentPage: currentState.currentPage + 1,
            ),
          );
        },
      );
    }
  }
}
