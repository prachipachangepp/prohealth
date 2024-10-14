class OnCallDocument{
  final int onCallId;
  final String name;
  final String htmlTemplate;
  OnCallDocument({required this.onCallId,required this.name,required this.htmlTemplate});
}

class CovidTestPolicyDocument{
  final String covidTestData;
  CovidTestPolicyDocument({required this.covidTestData});
}


class ConfidentialStatementDocument{
  final String confidentialDocument;
  ConfidentialStatementDocument({required this.confidentialDocument});
}

class ReportingAbuseDocument{
  final String reportingAbuseDocument;
  ReportingAbuseDocument({required this.reportingAbuseDocument});
}

class PolicyConcerningDocument{
  final String policyConcerningDocument;
  PolicyConcerningDocument({required this.policyConcerningDocument});
}