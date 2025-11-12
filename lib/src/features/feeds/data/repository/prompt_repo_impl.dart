// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dartz/dartz.dart';

import 'package:imaginez/src/core/error/failure.dart';
import 'package:imaginez/src/features/feeds/data/datatsources/prompts_api_source.dart';
import 'package:imaginez/src/features/feeds/data/mappers/prompt_mapper.dart';
import 'package:imaginez/src/features/feeds/data/models/prompt_model.dart';
import 'package:imaginez/src/features/feeds/domain/entity/prompt.dart';
import 'package:imaginez/src/features/feeds/domain/repository/prompt_repo.dart';

class PromptRepoImpl extends PromptRepo {
  final PromptsApiSource apiSource;
  PromptRepoImpl({required this.apiSource});

  @override
  Future<Either<AppError, List<Prompt>>> getPrompts({
    required String page,
    required String limit,
  }) async {
    try {
      final models = await apiSource.getPrompts(page: page, limit: limit);

      log('models : $models');

      final entities = (models as List)
          .cast<PromptModel>()
          .map(PromptMapper.toEntity)
          .toList();

      return Right(entities);
    } on AppError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnknownError(message: e.toString()));
    }
  }
}
