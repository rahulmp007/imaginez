import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:imaginez/src/core/network/api_client.dart';
import 'package:imaginez/src/core/network/api_constants.dart';
import 'package:imaginez/src/core/network/error_handler.dart';
import 'package:imaginez/src/features/feeds/data/models/prompt_model.dart';

class PromptsApiSource {
  final ApiClient client;
  PromptsApiSource({required this.client});

  Future getPrompts({required String page, required String limit}) async {
    debugPrint('loading prompts page : $page');
    try {
      final result = await client.get(
        url:
            '${ApiConstants.baseUrl}/${ApiConstants.prompts}?page=$page&limit=$limit',
      );

      final List<PromptModel> items = (result['prompts'] as List<dynamic>)
          .map((e) => PromptModel.fromJson(e))
          .toList();

      log('prompts : ${items.length}');

      return items;
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}
