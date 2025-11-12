class AttachmentModel {
  final String? fileName;
  final String? fileUrl;
  final String? fileType;
  final int? fileSize;
  final String? id;

  const AttachmentModel({
    this.fileName,
    this.fileUrl,
    this.fileType,
    this.fileSize,
    this.id,
  });

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      AttachmentModel(
        fileName: json['fileName'],
        fileUrl: json['fileUrl'],
        fileType: json['fileType'],
        fileSize: json['fileSize'],
        id: json['_id'],
      );
}
