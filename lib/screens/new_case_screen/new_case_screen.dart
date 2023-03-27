import 'package:flutter/material.dart';
import 'package:law_bot/model/case_model.dart';
import 'package:law_bot/screens/new_case_screen/result_screen.dart';
import 'package:law_bot/service/firabase_service.dart';
import 'package:law_bot/theme/theme.dart';
import 'package:law_bot/widgets/button.dart';
import 'package:law_bot/widgets/loading.dart';

class NewCaseScreen extends StatefulWidget {
  const NewCaseScreen({Key? key}) : super(key: key);

  @override
  State<NewCaseScreen> createState() => _NewCaseScreenState();
}

class _NewCaseScreenState extends State<NewCaseScreen> {
  final _globalKey = GlobalKey<ScaffoldMessengerState>();
  int _currentStep = 0;
  final ValueNotifier<bool> _complatedProccess = ValueNotifier(false);

  final TextEditingController caseNumber =
      TextEditingController(text: "2019/5678");
  final TextEditingController plaintiff =
      TextEditingController(text: "Ayşe Kılıç");
  final TextEditingController participating =
      TextEditingController(text: "Mehmet Yavuz");
  final TextEditingController defendant =
      TextEditingController(text: "Ebru Şahin");
  final TextEditingController crime = TextEditingController(text: "Fraud");

  final TextEditingController consideredDue = TextEditingController(
      text:
          "Ebru Şahin, as the owner of a company, has committed fraud by giving false information to her clients and not delivering the promised goods. The public prosecutor's office has filed a lawsuit against the defendant for fraud.");
  final TextEditingController defendantsDefense = TextEditingController(
      text:
          "I did not commit fraud. There were some issues with the delivery of goods due to unforeseen circumstances, but I have tried to resolve them as soon as possible. I have not given false information to my clients. I deny these charges.");
  final TextEditingController statementOfTheComplainant = TextEditingController(
      text:
          "I am one of Ebru Şahin's clients. She promised to deliver certain goods to me, but she did not deliver them. When I asked for an explanation, she gave me false information. I demand that she be punished for her actions.");
  final TextEditingController testimonyOfTheWitness = TextEditingController(
      text: "I witnessed Ebru Şahin giving false information to her clients.");

  List<String> caseAndVerdict = [
    "Ebru Şahin, as the owner of a company, has committed fraud by giving false information to her clients and not delivering the promised goods. The court determined that the defendant committed the crime. The defendant was sentenced to 1 year in prison under Article 157/1 of the Turkish Penal Code (TCK).",
    "Given the defendant's defense, other evidence in the case, and witness testimony, the court determined that the defendant committed the crime intentionally. The defendant did not admit guilt or express remorse. Therefore, her sentence was aggravated.",
    "The defendant's sentence will be executed under Article 105/1 of Law No. 5275 on the Execution of Penalties and Security Measures. The defendant will remain in custody until the judgment is final or until she exercises her right to appeal.",
    "The defendant will be required to pay all court costs.",
    "Based on the nature of the crime and the absence of any previous convictions for intentional crimes, it was decided to suspend the announcement of the verdict in accordance with Article 231 of Law no. 5271, and the defendant was placed on probation for a period of two years in accordance with Article 231-5 of the same law."
  ];
  List<String> theVerdictStatesThat = [
    "Ebru Şahin, as the owner of a company, has committed fraud by giving false information to her clients and not delivering the promised goods. The court determined that the defendant committed the crime. The defendant was sentenced to 1 year in prison under Article 157/1 of the Turkish Penal Code (TCK).",
    "Given the defendant's defense, other evidence in the case, and witness testimony, the court determined that the defendant committed the crime intentionally. The defendant did not admit guilt or express remorse. Therefore, her sentence was aggravated.",
    "The defendant's sentence will be executed under Article 105/1 of Law No. 5275 on the Execution of Penalties and Security Measures. The defendant will remain in custody until the judgment is final or until she exercises her right to appeal.",
    "The defendant will be required to pay all court costs.",
    "Based on the nature of the crime and the absence of any previous convictions for intentional crimes, it was decided to suspend the announcement of the verdict in accordance with Article 231 of Law no. 5271, and the defendant was placed on probation for a period of two years in accordance with Article 231-5 of the same law."
  ];

  List<String> similarDecision1 = [
    "John Doe, as a driver, has caused a car accident resulting in the death of a pedestrian. The court determined that the defendant committed the crime of manslaughter. The defendant was sentenced to 4 years in prison under Article 84/1 of the Criminal Code.",
    "Given the defendant's defense, other evidence in the case, and witness testimony, the court determined that the defendant was driving under the influence of alcohol at the time of the accident. The defendant did not admit guilt or express remorse. Therefore, his sentence was aggravated.",
    "The defendant's sentence will be executed under Article 105/1 of the Law on the Execution of Penalties and Security Measures. The defendant will remain in custody until the judgment is final or until he exercises his right to appeal.",
    "The defendant will be required to pay all court costs.",
    "Based on the nature of the crime and the presence of previous convictions for traffic offenses, it was decided not to suspend the announcement of the verdict. Therefore, the defendant will serve his sentence in full."
  ];
  List<String> similarDecision2 = [
    "John Smith has been found guilty of embezzlement. The court has determined that the defendant intentionally took money from his employer without authorization. He was sentenced to five years in prison under Section 61-3-701 of the Montana Code Annotated.",
    "The defendant showed no remorse and did not admit guilt. Based on the nature of the crime and the defendant's previous criminal history, his sentence was not suspended.",
    'The defendant will be required to pay restitution to his former employer in the amount of 100,000 dollar',
    "The court also ordered the defendant to participate in a rehabilitation program for financial crimes while in prison.",
    "The defendant has the right to appeal this decision within 30 days of the judgment becoming final."
  ];
  List<String> similarDecision3 = [
    "Samantha Johnson has been found guilty of grand larceny. The court determined that the defendant stole jewelry valued at 10,000 dollar from a local store. She was sentenced to three years in prison under Section 155.42 of the New York Penal Law.",
    "The defendant did not admit guilt or express remorse for her actions. Based on the nature of the crime, her sentence was not suspended.",
    "The defendant will be required to pay restitution to the store in the amount of 10,000 dollar",
    "The court also ordered the defendant to participate in a rehabilitation program for theft while in prison.",
    "The defendant has the right to appeal this decision within 30 days of the judgment becoming final."
  ];

  Map<String, dynamic> isValid(int currentStep) {
    return {"status": true, "message": "Bir Hata Oluştu!"};
  }

  ThemeData theme = ThemeManagement.instance.currentTheme;

  List<Step> _getSteps() => [
        Step(
            state: _currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: _currentStep >= 0,
            title: Text(
              "Case Number",
              style: theme.textTheme.titleLarge,
            ),
            content: TextFormField(
              controller: caseNumber,
            )),
        Step(
            state: _currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: _currentStep >= 1,
            title: Text(
              "Plaintiff Name",
              style: theme.textTheme.titleLarge,
            ),
            content: TextFormField(
              controller: plaintiff,
            )),
        Step(
            state: _currentStep > 2 ? StepState.complete : StepState.indexed,
            isActive: _currentStep >= 2,
            title: Text(
              "Participating Name",
              style: theme.textTheme.titleLarge,
            ),
            content: TextFormField(
              controller: participating,
            )),
        Step(
            state: _currentStep > 3 ? StepState.complete : StepState.indexed,
            isActive: _currentStep >= 3,
            title: Text(
              "Defendant Name",
              style: theme.textTheme.titleLarge,
            ),
            content: TextFormField(
              controller: defendant,
            )),
        Step(
            state: _currentStep > 4 ? StepState.complete : StepState.indexed,
            isActive: _currentStep >= 4,
            title: Text(
              "Crime",
              style: theme.textTheme.titleLarge,
            ),
            content: TextFormField(
              controller: crime,
            )),
        Step(
            state: _currentStep > 5 ? StepState.complete : StepState.indexed,
            isActive: _currentStep >= 5,
            title: Text(
              "Considered Due",
              style: theme.textTheme.titleLarge,
            ),
            content: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 150),
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: consideredDue,
              ),
            )),
        Step(
            state: _currentStep > 6 ? StepState.complete : StepState.indexed,
            isActive: _currentStep >= 6,
            title: Text(
              "Defendant's Defense",
              style: theme.textTheme.titleLarge,
            ),
            content: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 150),
              child: TextFormField(
                expands: true,
                controller: defendantsDefense,
                maxLines: null,
              ),
            )),
        Step(
            state: _currentStep > 7 ? StepState.complete : StepState.indexed,
            isActive: _currentStep >= 7,
            title: Text(
              "Statement Of The Complainant",
              style: theme.textTheme.titleLarge,
            ),
            content: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 150),
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: statementOfTheComplainant,
              ),
            )),
        Step(
            state: _currentStep > 8 ? StepState.complete : StepState.indexed,
            isActive: _currentStep >= 8,
            title: Text(
              "Testimony Of The Witness",
              style: theme.textTheme.titleLarge,
            ),
            content: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 150),
              child: TextFormField(
                expands: true,
                maxLines: null,
                controller: testimonyOfTheWitness,
              ),
            )),
        Step(
            state: _currentStep > 9 ? StepState.complete : StepState.indexed,
            isActive: _currentStep >= 9,
            title: Text(
              "Upload additional evidence (audio recording, video recording, etc.)",
              style: theme.textTheme.titleLarge,
            ),
            content: Row(
              children: [
                TextButton.icon(
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(theme.primaryColor)),
                  label: const Text("Upload File"),
                  icon: const Icon(Icons.attach_file),
                  onPressed: () {
                    //TODO:Later, artificial intelligence methods such as image processing and sound analysis can be introduced as evidence for the artificial intelligence model.
                  },
                ),
              ],
            )),
      ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: ScaffoldMessenger(
        key: _globalKey,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stepper(
                    physics: const NeverScrollableScrollPhysics(),
                    type: StepperType.vertical,
                    steps: _getSteps(),
                    currentStep: _currentStep,
                    controlsBuilder: (context, details) {
                      final isLastStep = _currentStep == _getSteps().length - 1;
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            StandardButton(
                                primary: theme.primaryColorLight,
                                text: isLastStep ? 'Conclusion' : "Continue",
                                onPressed: details.onStepContinue),
                            const SizedBox(width: 15),
                            if (_currentStep != 0)
                              StandardButton(
                                  primary: theme.primaryColorLight,
                                  text: "Back ",
                                  onPressed: details.onStepCancel),
                          ],
                        ),
                      );
                    },
                    onStepTapped: (step) {
                      setState(() => _currentStep = step);
                    },
                    onStepContinue: () async {
                      final isLastStep = _currentStep == _getSteps().length - 1;
                      String docId;
                      if (isLastStep) {
                        CaseModel data = CaseModel(
                            similarDecision1: similarDecision1,
                            similarDecision2: similarDecision2,
                            similarDecision3: similarDecision3,
                            caseNumber: caseNumber.text,
                            plaintiff: plaintiff.text,
                            participating: participating.text,
                            defendant: defendant.text,
                            crime: crime.text,
                            consideredDue: consideredDue.text,
                            defendantSDefense: defendantsDefense.text,
                            statementOfTheComplainant:
                                statementOfTheComplainant.text,
                            testimonyOfTheWitness: testimonyOfTheWitness.text,
                            caseAndVerdict: caseAndVerdict,
                            theVerdictStatesThat: theVerdictStatesThat);
                        try {
                          docId = await FirebaseService.instance.addCase(data);
                          _complatedProccess.value = false;
                          // ignore: use_build_context_synchronously
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) => LoadingDialog(
                                  isCompleted: _complatedProccess));
                          Future.delayed(const Duration(seconds: 5))
                              .then((value) => _complatedProccess.value = true)
                              .then((value) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ResultScreen(
                                            docId: docId,
                                            caseModel: data,
                                          ))));
                        } catch (e) {
                          print(e);
                        }
                      } else {
                        if (isValid(_currentStep)['status']) {
                          setState(() => _currentStep += 1);
                        } else {
                          _globalKey.currentState!.showSnackBar(SnackBar(
                              content: isValid(_currentStep)['message']));
                        }
                      }
                    },
                    onStepCancel: _currentStep == 0
                        ? null
                        : () => setState(() => _currentStep -= 1)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
