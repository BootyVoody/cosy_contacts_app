import 'package:cosy_contacts/domain/model/shortened_contact_model.dart';

class ShortenedContactDto {
  final int id;
  final String serviceName;
  final String partnerName;
  final String partnerTel;

  const ShortenedContactDto({
    required this.id,
    required this.serviceName,
    required this.partnerName,
    required this.partnerTel,
  });

  factory ShortenedContactDto.fromJson(dynamic json) => ShortenedContactDto(
        id: json['id'] as int,
        serviceName: json['serviceName'] as String,
        partnerName: json['partnerName'] as String,
        partnerTel: json['partnerTel'] as String,
      );

  ShortenedContactModel toModel() => ShortenedContactModel(
        id: id,
        serviceName: serviceName,
        partnerName: partnerName,
        partnerTel: partnerTel,
      );
}
