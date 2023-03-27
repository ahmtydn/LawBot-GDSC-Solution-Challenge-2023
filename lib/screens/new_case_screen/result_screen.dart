import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:law_bot/model/case_model.dart';
import 'package:law_bot/service/firabase_service.dart';
import 'package:law_bot/theme/theme.dart';

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

  Future<void> getRating() async {
    rating = await FirebaseService.instance.getRating(widget.docId);
  }

  @override
  void initState() {
    getRating();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("LawBot Case Result"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
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
                child: BuildTile( 
                    title: "Precedent Decision 1",
                    content: widget.caseModel.similarDecision1),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                child: BuildTile(
                    title: "Precedent Decision 2",
                    content: widget.caseModel.similarDecision2),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                child: BuildTile(
                    title: "Precedent Decision 1",
                    content: widget.caseModel.similarDecision2),
              ),
              const SizedBox(height: 15),
              Text(
                "Score the result produced:",
                style:
                    ThemeManagement.instance.currentTheme.textTheme.titleLarge,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BuildTile extends StatefulWidget {
  const BuildTile({
    super.key,
    required this.title,
    required this.content,
  });

  final String title;
  final List<String> content;

  @override
  State<BuildTile> createState() => _BuildTileState();
}

class _BuildTileState extends State<BuildTile> {
  bool customTileExpanded = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        widget.title,
        style: ThemeManagement.instance.currentTheme.textTheme.headlineMedium,
      ),
      children: List.generate(
          widget.content.length,
          (index) => ListTile(
                  title: Text(
                "\u2022 ${widget.content[index]}",
                style:
                    ThemeManagement.instance.currentTheme.textTheme.titleLarge,
              ))),
      onExpansionChanged: (bool expanded) {
        setState(() => customTileExpanded = expanded);
      },
    );
  }
}
