import 'package:flutter/material.dart';
import 'package:time_keeper/models/work_entry.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _workEntryRunning = false;
  WorkEntry? workEntry;

  void _createNewWorkEntry() {
    setState(() {
      _workEntryRunning = true;
      workEntry = WorkEntry(start: DateTime.now());
    });
  }

  void _stopWorkEntry() {
    setState(() {
      _workEntryRunning = false;
      workEntry!.end = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () =>
                _workEntryRunning ? _stopWorkEntry() : _createNewWorkEntry(),
            child: _workEntryRunning ? const Text("Stop") : const Text("Start"),
          ),
        ],
      ),
    );
  }
}
