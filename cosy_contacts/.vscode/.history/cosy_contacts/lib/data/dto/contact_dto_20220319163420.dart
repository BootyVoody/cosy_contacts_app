class ContactDto {
  final int id;
  final String parentId;
  final String serviceName;
  final String partnerName;
  final String partnerTel;
  final String? partnerEmail;
  final String? partnerMessenger;
  final String? comment;

  ContactDto(this.id, this.parentId, this.serviceName, this.partnerName,
      this.partnerTel, this.partnerEmail, this.partnerMessenger, this.comment);
}
