import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_bank_data/model/api_function.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'JSON Bank Data';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const Home(),
      ),
    );
  }
}

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getInsertDataProvider).when(
          data: (data) {
            
            return data!.isEmpty
                ? const Center(child: Text('No Data'))
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Principal Amount')),
                          DataColumn(label: Text('Annual Interest Rate')),
                        ],
                        rows: data
                            .map((e) => DataRow(cells: [
                                  DataCell(
                                      Text('${e.firstName!} ${e.lastName!}')),
                                  DataCell(Text(e.principalAmount!)),
                                  DataCell(Text(e.annualInterestRate!)),
                                ]))
                            .toList()),
                  );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stack) => Center(
            child: Text(error.toString()),
          ),
        );
  }
}
