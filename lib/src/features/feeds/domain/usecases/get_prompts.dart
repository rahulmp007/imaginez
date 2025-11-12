// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:imaginez/src/core/error/failure.dart';
import 'package:imaginez/src/features/feeds/domain/entity/prompt.dart';
import 'package:imaginez/src/features/feeds/domain/repository/prompt_repo.dart';

class GetPrompts {
  final PromptRepo promptRepo;
  GetPrompts({required this.promptRepo});
  Future<Either<AppError, List<Prompt>>> call({
    required String page,
    required String limit,
  }) async => await promptRepo.getPrompts(page: page, limit: limit);
}
