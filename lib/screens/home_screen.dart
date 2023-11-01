import 'package:flutter/material.dart';
import 'package:time_keeper/components/current_work_entry.dart';
import 'package:time_keeper/entities/work_entry.dart';
import 'package:time_keeper/services/isar_service.dart';

class HomeScreen extends StatefulWidget {
  final IsarService service;
  const HomeScreen({super.key, required this.service});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _workEntryRunning = false;
  late int workEntryId = 0;

  void _createNewWorkEntry() async {
    workEntryId =
        await widget.service.saveWorkEntry(WorkEntry()..start = DateTime.now());

    setState(() {
      _workEntryRunning = true;
    });
  }

  void _stopWorkEntry() {
    widget.service.setActualEndOnWorkEntry(workEntryId);

    setState(() {
      _workEntryRunning = false;
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
          if (_workEntryRunning)
            CurrentWorkEntry(service: widget.service, workEntryId: workEntryId),
        ],
      ),
    );
  }
}
