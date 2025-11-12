import 'package:equatable/equatable.dart';
import 'package:imaginez/src/features/feeds/domain/entity/attachment.dart';
import 'package:imaginez/src/features/feeds/domain/entity/created_by.dart';

class Prompt extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final List<String>? categories;
  final String? model;
  final List<dynamic>? variables;
  final int? upvotes;
  final int? usageCount;
  final CreatedBy? createdBy;
  final String? status;
  final String? tools;
  final String? systemprompt;
  final bool? isImagePrompt;
  final List<dynamic>? chainedPrompts;
  final List<Attachment>? attachments;
  final DateTime? createdAt;
  final int? v;

  const Prompt({
    this.id,
    this.title,
    this.description,
    this.categories,
    this.model,
    this.variables,
    this.upvotes,
    this.usageCount,
    this.createdBy,
    this.status,
    this.tools,
    this.systemprompt,
    this.isImagePrompt,
    this.chainedPrompts,
    this.attachments,
    this.createdAt,
    this.v,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    categories,
    model,
    variables,
    upvotes,
    usageCount,
    createdAt,
    status,
    createdAt,
  ];
}
