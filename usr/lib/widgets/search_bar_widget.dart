import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(Map<String, dynamic>) onSearch;
  final List<String> fields;

  const SearchBarWidget({super.key, required this.onSearch, required this.fields});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final Map<String, TextEditingController> _controllers = {};
  DateTime? _startDate;
  DateTime? _endDate;
  String? _status;

  @override
  void initState() {
    super.initState();
    for (var field in widget.fields) {
      if (field != 'dateRange' && field != 'status') {
        _controllers[field] = TextEditingController();
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  void _performSearch() {
    final params = <String, dynamic>{};
    for (var entry in _controllers.entries) {
      params[entry.key] = entry.value.text;
    }
    params['startDate'] = _startDate;
    params['endDate'] = _endDate;
    params['status'] = _status;
    widget.onSearch(params);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              children: widget.fields.map((field) {
                if (field == 'status') {
                  return DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Status'),
                    value: _status,
                    items: const [
                      DropdownMenuItem(value: 'Settled', child: Text('Settled')),
                      DropdownMenuItem(value: 'Fresh', child: Text('Fresh')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _status = value;
                      });
                    },
                  );
                } else if (field == 'dateRange') {
                  return ElevatedButton(
                    onPressed: () => _selectDateRange(context),
                    child: Text(
                      _startDate == null || _endDate == null
                          ? 'Select Date Range'
                          : '${DateFormat('yyyy-MM-dd').format(_startDate!)} - ${DateFormat('yyyy-MM-dd').format(_endDate!)}',
                    ),
                  );
                } else {
                  return SizedBox(
                    width: 150,
                    child: TextField(
                      controller: _controllers[field],
                      decoration: InputDecoration(labelText: field.toUpperCase()),
                    ),
                  );
                }
              }).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _performSearch,
              child: const Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}