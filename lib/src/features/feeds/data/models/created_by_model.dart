class CreatedByModel {
  final String? id;
  final String? name;

  const CreatedByModel({this.id, this.name});

  factory CreatedByModel.fromJson(Map<String, dynamic> json) =>
      CreatedByModel(id: json['_id'], name: json['name']);
}
