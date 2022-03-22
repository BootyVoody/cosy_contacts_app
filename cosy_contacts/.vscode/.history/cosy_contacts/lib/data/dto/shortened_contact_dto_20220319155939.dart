class ShortenedContactDto {
  final int id;
  final String serviceName

  const ShortenedContactDto({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory ShortenedContactDto.fromJson(dynamic json) => ShortenedContactDto(
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