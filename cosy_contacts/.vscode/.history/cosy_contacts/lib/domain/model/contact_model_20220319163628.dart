class ContactModel {
  final int id;
  final int parentId;
  final String serviceName;
  final String partnerName;
  final String partnerTel;
  final String? partnerEmail;
  final String? partnerMessenger;
  final String? comment;

  ContactModel({
    required this.id,
    required this.parentId,
    required this.serviceName,
    required this.partnerName,
    required this.partnerTel,
    required this.partnerEmail,
    required this.partnerMessenger,
    required this.comment,
  });
}
