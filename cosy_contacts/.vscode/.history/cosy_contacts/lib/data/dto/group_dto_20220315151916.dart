class GroupDto {
  final int id;
  final String name;

  const GroupDto({
    required this.id,
    required this.name,
  });

  factory GroupDto.fromJson(dynamic json) => GroupDto();
}
