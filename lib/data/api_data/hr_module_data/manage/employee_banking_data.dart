class EmployeeBankingData {
  final int empBankingId;
  final int employeeId;
  final String accountNumber;
  final String bankName;
  final int amountRequested;
  final String checkUrl;
  final String effectiveDate;
  final String routinNumber;
  final String type;
   bool? approve;
  // final bool sucess;
  // final String message;

  EmployeeBankingData({
    required this.empBankingId,
    required this.employeeId,
    required this.accountNumber,
    required this.bankName,
    required this.amountRequested,
    required this.checkUrl,
    required this.effectiveDate,
    required this.routinNumber,
    required this.type,
    this.approve,
    // required this.sucess,
    // required this.message,
  });
}

class EmployeeBankingPrefillData {
  final int empBankingId;
  final int employeeId;
  final String accountNumber;
  final String bankName;
  final int amountRequested;
  final String checkUrl;
  final String effectiveDate;
  final String routinNumber;
  final String type;
  final bool? approve;
  final String percentage;

  EmployeeBankingPrefillData({required this.percentage,
    required this.empBankingId,
    required this.employeeId,
    required this.accountNumber,
    required this.bankName,
    required this.amountRequested,
    required this.checkUrl,
    required this.effectiveDate,
    required this.routinNumber,
    required this.type,
    this.approve,

  });
}


