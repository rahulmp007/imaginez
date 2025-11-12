import 'package:equatable/equatable.dart';

class Attachment extends Equatable {
  final String? fileName;
  final String? fileUrl;
  final String? fileType;
  final int? fileSize;
  final String? id;

  const Attachment({
    this.fileName,
    this.fileUrl,
    this.fileType,
    this.fileSize,
    this.id,
  });

  @override
  List<Object?> get props => [fileName, fileUrl, fileType, fileSize, id];
}
