import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:law_bot/model/case_model.dart';
import 'package:law_bot/service/firabase_service.dart';
import 'package:law_bot/theme/theme.dart';
import 'package:law_bot/widgets/build_tile.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key, required this.caseModel, required this.docId})
      : super(key: key);

  final CaseModel caseModel;
  final String docId;
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  double rating = 0.0;
  bool _loading = false;

  Future<void> getRating() async {
    setState(() {
      _loading = true;
    });
    rating = await FirebaseService.instance.getRating(widget.docId);
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    getRating();
    print(rating);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("LawBot Case Result"),
      ),
      body: _loading
          ? const CircularProgressIndicator()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Result",
                        style: TextStyle(
                            color: ThemeManagement
                                .instance.currentTheme.primaryColorLight,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      child: BuildTile(
                          title: "Case And Verdict",
                          content: widget.caseModel.caseAndVerdict),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      child: BuildTile(
                          title: "The Verdict States That",
                          content: widget.caseModel.theVerdictStatesThat),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      child: BuildTile(title: "Precedent Decisions", content2: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Row(
                            children: [
                              const Text("\u2022"),
                              Expanded(
                                child: BuildTile(
                                    title: "Precedent Decision 1",
                                    content: widget.caseModel.similarDecision1),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Row(
                            children: [
                              const Text("\u2022"),
                              Expanded(
                                child: BuildTile(
                                    title: "Precedent Decision 2",
                                    content: widget.caseModel.similarDecision2),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Row(
                            children: [
                              const Text("\u2022"),
                              Expanded(
                                child: BuildTile(
                                    title: "Precedent Decision 3",
                                    content: widget.caseModel.similarDecision3),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Score the result produced:",
                      style: ThemeManagement
                          .instance.currentTheme.textTheme.titleLarge,
                    ),
                    RatingBar.builder(
                      initialRating: rating,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) async {
                        try {
                          await FirebaseService.instance
                              .updateRating(rating, widget.docId);
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                    const SizedBox(height: 5),
                    Card(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Case Details",
                                  style: TextStyle(
                                      color: ThemeManagement.instance
                                          .currentTheme.primaryColorLight,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            height: 2,
                            color: ThemeManagement
                                .instance.currentTheme.primaryColorLight,
                          ),
                          BuildTile(
                              title: "Crime",
                              content: [widget.caseModel.crime]),
                          BuildTile(
                              title: "Participating",
                              content: [widget.caseModel.participating]),
                          BuildTile(
                              title: "Defendant",
                              content: [widget.caseModel.defendant]),
                          BuildTile(
                              title: "Plaintiff",
                              content: [widget.caseModel.plaintiff]),
                          BuildTile(
                              title: "Occurrence and Acceptance",
                              content: [
                                widget.caseModel.occurrenceAndAcceptance
                              ]),
                          BuildTile(
                              title: "Statement of the Complainant",
                              content: [
                                widget.caseModel.statementOfTheComplainant
                              ]),
                          BuildTile(
                              title: "Defendant's Defense",
                              content: [widget.caseModel.defendantSDefense]),
                          BuildTile(
                              title: "Testimony of the Witness",
                              content: [
                                widget.caseModel.testimonyOfTheWitness
                              ]),
                          BuildTile(
                              title: "Testimony of the Witness",
                              content: [
                                widget.caseModel.testimonyOfTheWitness
                              ]),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
