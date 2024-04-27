import 'package:flutter/material.dart';

class PersistentTransportWidget extends StatefulWidget {
  const PersistentTransportWidget({super.key});

  @override
  State<PersistentTransportWidget> createState() =>
      _PersistentTransportWidgetState();
}

class _PersistentTransportWidgetState extends State<PersistentTransportWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Tồn ca"),
    );
  }
}
