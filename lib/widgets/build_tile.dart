import 'package:flutter/material.dart';
import 'package:law_bot/theme/theme.dart';

class BuildTile extends StatefulWidget {
  const BuildTile({
    super.key,
    required this.title,
    this.content,
    this.content2,
  });

  final String title;
  final List<String>? content;
  final List<Widget>? content2;

  @override
  State<BuildTile> createState() => _BuildTileState();
}

class _BuildTileState extends State<BuildTile> {
  bool customTileExpanded = false;
  @override
  Widget build(BuildContext context) {
    return widget.content != null
        ? ExpansionTile(
            title: Text(
              widget.title,
              style: TextStyle(color: ThemeManagement.instance.currentTheme.primaryColorLight),
            ),
            children: List.generate(
                widget.content!.length,
                (index) => ListTile(
                        title: Text(
                      "\u2022 ${widget.content![index]}",
                      style: ThemeManagement
                          .instance.currentTheme.textTheme.titleLarge,
                    ))),
            onExpansionChanged: (bool expanded) {
              setState(() => customTileExpanded = expanded);
            },
          )
        : ExpansionTile(
            title: Text(
              widget.title,
              style: TextStyle(color: ThemeManagement.instance.currentTheme.primaryColorLight),
            ),
            children: List.generate(
                widget.content2!.length, (index) => widget.content2![index]),
            onExpansionChanged: (bool expanded) {
              setState(() => customTileExpanded = expanded);
            },
          );
  }
}
