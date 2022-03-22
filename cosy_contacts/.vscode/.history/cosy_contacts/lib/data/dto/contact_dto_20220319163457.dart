class ContactDto {
  final int id;
  final String parentId;
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
