import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imaginez/src/core/network/connectivity/bloc/network_bloc.dart';
import 'package:imaginez/src/core/network/connectivity/bloc/network_event.dart';
import 'package:imaginez/src/core/network/connectivity/bloc/network_state.dart';

class NetworkAware extends StatefulWidget {
  final Widget child;
  final Future<void> Function()? onRefresh;
  const NetworkAware({required this.child, this.onRefresh, super.key});

  @override
  State<NetworkAware> createState() => _NetworkAwareState();
}

class _NetworkAwareState extends State<NetworkAware> {
  Timer? _hideTimer;
  bool _showBanner = false;
  NetworkState? _previousState;
  bool _isFirstState = true;

  @override
  void dispose() {
    _hideTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _handleStateChange(NetworkState newState) {
    if (_isFirstState) {
      _isFirstState = false;
      _previousState = newState;
      return;
    }

    final shouldShow =
        (_previousState is NetworkOnline && newState is NetworkOffline) ||
        (_previousState is NetworkOffline && newState is NetworkOnline);

    _hideTimer?.cancel();

    if (shouldShow) {
      setState(() => _showBanner = true);
      _hideTimer = Timer(const Duration(seconds: 2), () {
        if (mounted) setState(() => _showBanner = false);
      });
    } else {
      setState(() => _showBanner = false);
    }

    _previousState = newState;
  }

  Future<void> _handleRefresh() async {
    context.read<NetworkBloc>().add(NetwrokRefreshRequested());
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Stack(
        children: [
          RefreshIndicator(
            onRefresh: _handleRefresh,
            child: CustomScrollView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: SafeArea(child: widget.child)),
              ],
            ),
          ),

          BlocListener<NetworkBloc, NetworkState>(
            listener: (context, state) => _handleStateChange(state),
            child: BlocBuilder<NetworkBloc, NetworkState>(
              buildWhen: (previous, current) =>
                  previous.networkType != current.networkType,
              builder: (context, state) => AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                top: _showBanner ? 0 : -50,
                left: 0,
                right: 0,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: state is NetworkOffline
                        ? Colors.redAccent
                        : Colors.green,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      state is NetworkOffline
                          ? 'Internet Disconnected'
                          : 'Internet Connected',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
