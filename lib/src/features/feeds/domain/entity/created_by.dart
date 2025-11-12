import 'package:equatable/equatable.dart';

class CreatedBy extends Equatable {
  final String? id;
  final String? name;

  const CreatedBy({this.id, this.name});

  @override
  List<Object?> get props => [id, name];
}
