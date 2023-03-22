import 'package:flutter/material.dart';

typedef NotifierBuilder<T extends ChangeNotifier> = Widget Function(
    BuildContext context, T value);

class ListenerWidget<T extends ChangeNotifier> extends StatefulWidget {
  const ListenerWidget(
      {required this.notifier, required this.builder, Key? key})
      : super(key: key);
  final T notifier;
  final NotifierBuilder<T> builder;

  @override
  State<ListenerWidget> createState() => _ListenerWidgetState<T>();
}

class _ListenerWidgetState<T extends ChangeNotifier>
    extends State<ListenerWidget<T>> {
  void _valueChanged() {
    setState(() {});
  }

  @override
  void initState() {
    widget.notifier.addListener(_valueChanged);
    super.initState();
  }

  @override
  void didUpdateWidget(ListenerWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.notifier != widget.notifier) {
      oldWidget.notifier.removeListener(_valueChanged);
      widget.notifier.addListener(_valueChanged);
    }
  }

  @override
  void dispose() {
    widget.notifier.removeListener(_valueChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.notifier);
  }
}
