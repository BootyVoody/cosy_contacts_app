import 'package:cosy_contacts/domain/model/group_model.dart';

class GroupDto {
  final int id;
  final String name;

  const GroupDto({
    required this.id,
    required this.name,
  });

  factory GroupDto.fromJson(dynamic json) => GroupDto(
        id: json['id'] as int,
        name: json['name'] as String,
      );

  GroupModel toModel() => GroupModel(
        id: id,
        name: name,
      );
}
