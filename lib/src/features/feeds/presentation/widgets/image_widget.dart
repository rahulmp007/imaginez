import 'package:flutter/material.dart';
import 'package:imaginez/src/features/feeds/domain/entity/prompt.dart';

class ImageWidget extends StatelessWidget {
  final Prompt prompt;
  const ImageWidget({super.key, required this.prompt});

  @override
  Widget build(BuildContext context) => Image.network(
      prompt.attachments?.isNotEmpty ?? false
          ? prompt.attachments?.first.fileUrl ?? ''
          : '',
      fit: BoxFit.contain,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(
          child: CircularProgressIndicator(color: Colors.white70),
        );
      },
      errorBuilder: (context, error, stackTrace) => Container(
          color: Colors.grey.shade900,
          alignment: Alignment.center,
          child: const Icon(
            Icons.broken_image_rounded,
            size: 64,
            color: Colors.white38,
          ),
        ),
    );
}
