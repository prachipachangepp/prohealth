class CiOrgDocumentCC {
  final String? name;
  final String? expiry;
  final String? reminderThreshold;
  final String? createdAt;
  final bool sucess;
  final String message;

  CiOrgDocumentCC(
      {required this.sucess,
      required this.message,
        this.createdAt,
        this.name,
      this.expiry,
      this.reminderThreshold});
}
