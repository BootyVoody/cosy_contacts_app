import 'package:cosy_contacts/domain/model/group_model.dart';

class GroupDto {
  final int id;
  final String name;
  final String imageUrl;

  const GroupDto({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory GroupDto.fromJson(dynamic json) => GroupDto(
        id: json['id'] as int,
        name: json['name'] as String,
        imageUrl: json['imageUrl'] as String,
      );

  GroupModel toModel() => GroupModel(
        id: id,
        name: name,
        imageUrl: imageUrl,
      );
}
