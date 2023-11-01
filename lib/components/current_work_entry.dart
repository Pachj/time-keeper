import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_keeper/entities/work_entry.dart';
import 'package:time_keeper/services/isar_service.dart';

class CurrentWorkEntry extends StatefulWidget {
  final IsarService service;
  final int workEntryId;

  const CurrentWorkEntry(
      {required this.workEntryId, required this.service, super.key});

  @override
  State<CurrentWorkEntry> createState() => _CurrentWorkEntryState();
}

class _CurrentWorkEntryState extends State<CurrentWorkEntry> {
  WorkEntry? workEntry;

  @override
  void initState() {
    super.initState();
    _loadWorkEntry();
  }

  Future<void> _loadWorkEntry() async {
    workEntry = await widget.service.getWorkEntry(widget.workEntryId);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              const Text('Starting Time: '),
              if (workEntry != null)
                Text(DateFormat.yMd().add_jm().format(workEntry!.start)),
            ],
          ),
        ],
      ),
    );
  }
}
