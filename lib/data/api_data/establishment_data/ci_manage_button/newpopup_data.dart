class TypeofDocpopup {
  final int orgDocumentSetupid;
  final int documenttypeid;
  final int documentsubtypeid;
  final String docname;
  final String expirytype;
  final int threshold;
  final String expirydate;
  final String expiryreminder;
  final int companyid;
  final String idOfDocument;
  final bool? hasIssuerExpiry;

  TypeofDocpopup(
      {required this.orgDocumentSetupid,
      required this.documenttypeid,
      required this.documentsubtypeid,
      required this.docname,
      required this.expirytype,
      required this.threshold,
      required this.expirydate,
      required this.expiryreminder,
      required this.companyid,
      required this.idOfDocument,
        this.hasIssuerExpiry,
      });
}
