class WhitelabellingModel {
  final String? companyName;
  final String? primeNo;
  final String? secNo;
  final String? alterNo;
  final String? fax;
  final bool? sucess;
  final String? message;

  WhitelabellingModel(this.sucess,
      {
        this.companyName,
        this.primeNo,
        this.secNo,
        this.alterNo,
        this.fax,
        this.message,
      });
}