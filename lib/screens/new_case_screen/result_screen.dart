import 'package:flutter/material.dart';
import 'package:law_bot/model/case_model.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key, required this.caseModel}) : super(key: key);

  final CaseModel caseModel;
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("LawBot Case Result"),
      ),
      body: Column(
        children: List.generate(widget.caseModel.caseAndVerdict.length,
            (index) => Text(widget.caseModel.caseAndVerdict[index])),
      ),
    );
  }
}
