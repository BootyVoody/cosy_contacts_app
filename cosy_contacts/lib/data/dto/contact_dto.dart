import 'package:cosy_contacts/domain/model/contact_model.dart';

class ContactDto {
  final int id;
  final int parentId;
  final String serviceName;
  final String partnerName;
  final String partnerTel;
  final String? partnerEmail;
  final String? partnerMessenger;
  final String? comment;

  ContactDto({
    required this.id,
    required this.parentId,
    required this.serviceName,
    required this.partnerName,
    required this.partnerTel,
    required this.partnerEmail,
    required this.partnerMessenger,
    required this.comment,
  });

  factory ContactDto.fromJson(dynamic json) => ContactDto(
        id: json['id'] as int,
        parentId: json['parentId'] as int,
        serviceName: json['serviceName'] as String,
        partnerName: json['partnerName'] as String,
        partnerTel: json['partnerTel'] as String,
        partnerEmail: json['partnerEmail'] as String?,
        partnerMessenger: json['partnerMessenger'] as String?,
        comment: json['comment'] as String?,
      );

  ContactModel toModel() => ContactModel(
        id: id,
        parentId: parentId,
        serviceName: serviceName,
        partnerName: partnerName,
        partnerTel: partnerTel,
        partnerEmail: partnerEmail,
        partnerMessenger: partnerMessenger,
        comment: comment,
      );
}
