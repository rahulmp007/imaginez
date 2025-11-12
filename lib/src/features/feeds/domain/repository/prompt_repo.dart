import 'package:dartz/dartz.dart';
import 'package:imaginez/src/core/error/failure.dart';
import 'package:imaginez/src/features/feeds/domain/entity/prompt.dart';

abstract class PromptRepo {
  Future<Either<AppError, List<Prompt>>> getPrompts({
    required String page,
    required String limit,
  });
}
