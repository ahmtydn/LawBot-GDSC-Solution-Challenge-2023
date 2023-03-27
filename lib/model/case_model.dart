class CaseModel {
  CaseModel({
    required this.caseNumber,
    required this.plaintiff,
    required this.participating,
    required this.defendant,
    required this.crime,
    required this.consideredDue,
    required this.defendantSDefense,
    required this.statementOfTheComplainant,
    required this.testimonyOfTheWitness,
    required this.similarDecision1,
    required this.similarDecision2,
    required this.similarDecision3,
    required this.caseAndVerdict,
    required this.theVerdictStatesThat,
  });

  String caseNumber;
  String plaintiff;
  String participating;
  String defendant;
  String crime;
  String consideredDue;
  String defendantSDefense;
  String statementOfTheComplainant;
  String testimonyOfTheWitness;
  List<String> caseAndVerdict;
  List<String> similarDecision1;
  List<String> similarDecision2;
  List<String> similarDecision3;
  List<String> theVerdictStatesThat;

  factory CaseModel.fromJson(Map<String, dynamic> json) => CaseModel(
        caseNumber: json["case_number"],
        plaintiff: json["plaintiff"],
        participating: json["participating"],
        defendant: json["defendant"],
        crime: json["crime"],
        consideredDue: json["considered_due"],
        defendantSDefense: json["defendant's_defense"],
        statementOfTheComplainant: json["statement_of_the_complainant"],
        testimonyOfTheWitness: json["testimony_of_the_witness"],
        caseAndVerdict:
            List<String>.from(json["case_and_verdict"].map((x) => x)),
        similarDecision1:
            List<String>.from(json["similar_decisions1"].map((x) => x)),
        similarDecision2:
            List<String>.from(json["similar_decisions2"].map((x) => x)),
        similarDecision3:
            List<String>.from(json["similar_decisions3"].map((x) => x)),
        theVerdictStatesThat:
            List<String>.from(json["the_verdict_states_that"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "case_number": caseNumber,
        "plaintiff": plaintiff,
        "participating": participating,
        "defendant": defendant,
        "crime": crime,
        "considered_due": consideredDue,
        "defendant's_defense": defendantSDefense,
        "statement_of_the_complainant": statementOfTheComplainant,
        "testimony_of_the_witness": testimonyOfTheWitness,
        "case_and_verdict": List<dynamic>.from(caseAndVerdict.map((x) => x)),
        "similar_decisions1":
            List<dynamic>.from(similarDecision1.map((x) => x)),
        "similar_decisions2":
            List<dynamic>.from(similarDecision2.map((x) => x)),
        "similar_decisions3":
            List<dynamic>.from(similarDecision3.map((x) => x)),
        "the_verdict_states_that":
            List<dynamic>.from(theVerdictStatesThat.map((x) => x)),
      };
}
