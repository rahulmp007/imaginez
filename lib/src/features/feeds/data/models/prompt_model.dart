import 'package:imaginez/src/features/feeds/data/models/attachment_model.dart';
import 'package:imaginez/src/features/feeds/data/models/created_by_model.dart';

class PromptModel {
  final String? id;
  final String? title;
  final String? description;
  final List<String>? categories;
  final String? model;
  final List<dynamic>? variables;
  final int? upvotes;
  final int? usageCount;
  final CreatedByModel? createdBy;
  final String? status;
  final String? tools;
  final String? systemprompt;
  final bool? isImagePrompt;
  final List<dynamic>? chainedPrompts;
  final List<AttachmentModel>? attachments;
  final DateTime? createdAt;
  final int? v;

  const PromptModel({
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

  factory PromptModel.fromJson(Map<String, dynamic> json) => PromptModel(
    id: json['_id'],
    title: json['title'],
    description: json['description'],
    categories: json['categories'] == null
        ? []
        : List<String>.from(json['categories']?.map((x) => x)),
    model: json['model'],
    variables: json['variables'] == null
        ? []
        : List<dynamic>.from(json['variables']!.map((x) => x)),
    upvotes: json['upvotes'],
    usageCount: json['usageCount'],
    createdBy: json['createdBy'] == null
        ? null
        : CreatedByModel.fromJson(json['createdBy']),
    status: json['status'],
    tools: json['tools'],
    systemprompt: json['systemprompt'],
    isImagePrompt: json['isImagePrompt'],
    chainedPrompts: json['chainedPrompts'] == null
        ? []
        : List<dynamic>.from(json['chainedPrompts']!.map((x) => x)),
    attachments: json['attachments'] == null
        ? []
        : List<AttachmentModel>.from(
            json['attachments']!.map((x) => AttachmentModel.fromJson(x)),
          ),
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt']),
    v: json['__v'],
  );
}
