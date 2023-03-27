import 'package:flutter/material.dart';
import 'package:law_bot/model/case_model.dart';
import 'package:law_bot/screens/new_case_screen/result_screen.dart';
import 'package:law_bot/service/firabase_service.dart';
import 'package:law_bot/theme/theme.dart';
import 'package:law_bot/widgets/build_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "LawBot",
          style: TextStyle(
              color: ThemeManagement.instance.currentTheme.primaryColorLight),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseService.instance.streamCases(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData &&
                snapshot.data != null &&
                snapshot.data!.isNotEmpty) {
              final List<CaseModel> resultData = snapshot.data!;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: List.generate(resultData.length, (index) {
                      final data = resultData[index];
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Case Number: ${data.caseNumber}",
                                      style: TextStyle(
                                          color: ThemeManagement.instance
                                              .currentTheme.primaryColorLight,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                        style: ButtonStyle(
                                            foregroundColor:
                                                MaterialStateProperty.all(
                                                    ThemeManagement
                                                        .instance
                                                        .currentTheme
                                                        .primaryColor)),
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ResultScreen(
                                                          caseModel: data,
                                                          docId: data.id!)));
                                        },
                                        child: const Text("Detail"))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              );
            } else {
              return Center(
                child: Text(
                  "No litigation results questioned",
                  style: TextStyle(
                      color: ThemeManagement.instance.currentTheme.hintColor,
                      fontSize: 17),
                ),
              );
            }
          }),
    );
  }
}
