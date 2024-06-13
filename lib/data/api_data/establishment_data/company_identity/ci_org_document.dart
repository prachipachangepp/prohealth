class CiOrgDocumentCC {
  final int? docId;
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
        this.docId,
        this.name,
      this.expiry,
      this.reminderThreshold});
}
class OrgDocModal {
  final int? docId;
  final String? name;
  final String? expiry;
  final String? reminderThreshold;
  final String? createdAt;
  final bool sucess;
  final String message;

  OrgDocModal({required this.sucess,
    required this.message,
    this.createdAt,
    this.docId,
    this.name,
    this.expiry,
    this.reminderThreshold});
}