import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:imaginez/src/core/routing/route_paths.dart';
import 'package:imaginez/src/features/feeds/presentation/bloc/prompts/prompts_bloc.dart';
import 'package:imaginez/src/features/feeds/presentation/bloc/prompts/prompts_event.dart';
import 'package:imaginez/src/features/feeds/presentation/bloc/prompts/prompts_state.dart';
import 'package:imaginez/src/features/feeds/presentation/widgets/image_widget.dart';
import 'package:imaginez/src/features/feeds/presentation/widgets/prompt_action.dart';
import 'package:imaginez/src/features/feeds/presentation/widgets/user_image.dart';
import 'package:imaginez/src/shared/widgets/error_widget.dart';

class PromptsList extends StatefulWidget {
  const PromptsList({super.key});

  @override
  State<PromptsList> createState() => _PromptsListState();
}

class _PromptsListState extends State<PromptsList> {
  final PageController _pageController = PageController();
  late PromptBloc _promptBloc;

  @override
  void initState() {
    super.initState();
    _promptBloc = context.read<PromptBloc>();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool _onScrollNotification(ScrollNotification notification) {
    final state = _promptBloc.state;

    if (state is PromptLoaded && state.hasMore && state is! PromptPaginating) {
      if (notification is UserScrollNotification) {
        final metrics = notification.metrics;

        if (notification.direction == ScrollDirection.reverse &&
            metrics.pixels >= metrics.maxScrollExtent) {
          _loadMoreData(state);
          return true;
        }
      }
    }
    return false;
  }

  void _loadMoreData(PromptLoaded state) {
    if (state.hasMore && state is! PromptPaginating) {
      _promptBloc.add(
        LoadMorePrompts(page: (state.currentPage + 1).toString(), limit: '10'),
      );
    }
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<PromptBloc, PromptState>(
    builder: (context, state) {
      if (state is PromptLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is PromptError) {
        return ErrorPage(
          message: state.message,
          onRetry: () {
            context.read<PromptBloc>().add(const LoadPrompts(limit: '10'));
          },
        );
      } else if (state is PromptLoaded) {
        final prompts = state.prompts;
        final hasMore = state.hasMore;

        return NotificationListener<ScrollNotification>(
          onNotification: _onScrollNotification,
          child: Stack(
            children: [
              // Main Content - PageView without loading indicator as item
              PageView.builder(
                scrollDirection: Axis.vertical,
                controller: _pageController,
                itemCount: prompts.length,
                itemBuilder: (context, index) {
                  final prompt = prompts[index];

                  return Container(
                    color: Colors.black,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ImageWidget(prompt: prompt),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Colors.black54, Colors.transparent],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 80,
                          right: 15,
                          child: SizedBox(
                            height: 240,
                            width: 60,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const PromptActionWidget(
                                  icon: Icon(
                                    Icons.favorite_outline_rounded,
                                    color: Colors.white,
                                  ),
                                  subtitle: Text(
                                    '4k',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const PromptActionWidget(
                                  icon: Icon(
                                    Icons.share_rounded,
                                    color: Colors.white,
                                  ),
                                  subtitle: Text(
                                    '100',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 45,
                                  width: 45,
                                  child: FloatingActionButton(
                                    backgroundColor: Colors.white,
                                    onPressed: () {
                                      context.push(
                                        RoutePaths.generate,
                                        extra: prompt,
                                      );
                                    },
                                    child: const Icon(
                                      Icons.add_rounded,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              // Loading indicator overlay (Instagram style)
              // Show at the bottom when paginating
              if (state is PromptPaginating)
                Positioned(
                  bottom: 0, // Show at the very bottom
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 80, // Slightly taller to be more visible
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.8),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Loading more...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Error overlay for pagination errors
              if (state is PromptPaginationError)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.8),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Failed to load more: ${state.message}',
                          style: TextStyle(
                            color: Colors.red[300],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 6),
                        GestureDetector(
                          onTap: () => _loadMoreData(state),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Text(
                              'Retry',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Show "no more content" message when there's no more data
              if (!hasMore && prompts.isNotEmpty)
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      'No more content',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),

              // Top avatar
              Positioned(
                top: 16,
                left: 16,
                child: GestureDetector(
                  onTap: () {
                    context.push(RoutePaths.profile);
                  },
                  child: const UserImage(),
                ),
              ),
            ],
          ),
        );
      }

      return const SizedBox.shrink();
    },
  );
}
