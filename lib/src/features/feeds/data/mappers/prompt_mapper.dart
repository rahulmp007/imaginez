// lib/features/prompts_feeds/data/mappers/mappers.dart

import 'package:imaginez/src/features/feeds/data/models/attachment_model.dart';
import 'package:imaginez/src/features/feeds/domain/entity/attachment.dart';
import 'package:imaginez/src/features/feeds/data/models/created_by_model.dart';
import 'package:imaginez/src/features/feeds/domain/entity/created_by.dart';
import 'package:imaginez/src/features/feeds/data/models/prompt_model.dart';
import 'package:imaginez/src/features/feeds/domain/entity/prompt.dart';

/// ------------------------------------------------------------
/// 🧩 CreatedByMapper
/// ------------------------------------------------------------
class CreatedByMapper {
  static CreatedBy toEntity(CreatedByModel? model) {
    if (model == null) return const CreatedBy();
    return CreatedBy(id: model.id, name: model.name);
  }

  static CreatedByModel fromEntity(CreatedBy? entity) {
    if (entity == null) return const CreatedByModel();
    return CreatedByModel(id: entity.id, name: entity.name);
  }
}

/// ------------------------------------------------------------
/// 📎 AttachmentMapper
/// ------------------------------------------------------------
class AttachmentMapper {
  static Attachment toEntity(AttachmentModel model) => Attachment(
      id: model.id,
      fileName: model.fileName,
      fileUrl: model.fileUrl,
      fileType: model.fileType,
      fileSize: model.fileSize,
    );

  static AttachmentModel fromEntity(Attachment entity) => AttachmentModel(
      id: entity.id,
      fileName: entity.fileName,
      fileUrl: entity.fileUrl,
      fileType: entity.fileType,
      fileSize: entity.fileSize,
    );

  static List<Attachment> toEntityList(List<AttachmentModel>? models) => models?.map(toEntity).toList() ?? [];

  static List<AttachmentModel> fromEntityList(List<Attachment>? entities) => entities?.map(fromEntity).toList() ?? [];
}

/// ------------------------------------------------------------
/// 💬 PromptMapper
/// ------------------------------------------------------------
class PromptMapper {
  static Prompt toEntity(PromptModel model) => Prompt(
      id: model.id,
      title: model.title,
      description: model.description,
      categories: model.categories,
      model: model.model,
      variables: model.variables,
      upvotes: model.upvotes,
      usageCount: model.usageCount,
      createdBy: CreatedByMapper.toEntity(model.createdBy),
      status: model.status,
      tools: model.tools,
      systemprompt: model.systemprompt,
      isImagePrompt: model.isImagePrompt,
      chainedPrompts: model.chainedPrompts,
      attachments: AttachmentMapper.toEntityList(model.attachments),
      createdAt: model.createdAt,
      v: model.v,
    );

  static PromptModel fromEntity(Prompt entity) => PromptModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      categories: entity.categories,
      model: entity.model,
      variables: entity.variables,
      upvotes: entity.upvotes,
      usageCount: entity.usageCount,
      createdBy: CreatedByMapper.fromEntity(entity.createdBy),
      status: entity.status,
      tools: entity.tools,
      systemprompt: entity.systemprompt,
      isImagePrompt: entity.isImagePrompt,
      chainedPrompts: entity.chainedPrompts,
      attachments: AttachmentMapper.fromEntityList(entity.attachments),
      createdAt: entity.createdAt,
      v: entity.v,
    );

  static List<Prompt> toEntityList(List<PromptModel> models) => models.map(toEntity).toList();

  static List<PromptModel> fromEntityList(List<Prompt> entities) => entities.map(fromEntity).toList();
}
