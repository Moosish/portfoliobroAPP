import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ScreenOne extends StatelessWidget {
  final List<Map<String, dynamic>> _stockData = [
    {'name': 'AAPL', 'shares': 50, 'currentPrice': 150.0},
    {'name': 'GOOGL', 'shares': 30, 'currentPrice': 2800.0},
    {'name': 'AMZN', 'shares': 10, 'currentPrice': 3200.0},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        Card(
          child: ListTile(
            title: const Text('Total Portfolio Value'),
            subtitle: Text('\$${_calculateTotalValue().toStringAsFixed(2)}'),
            trailing: Icon(Icons.account_balance_wallet),
          ),
        ),
        ..._stockData.map((stock) => Card(
          child: ListTile(
            title: Text(stock['name']),
            subtitle: Text('Shares: ${stock['shares']}'),
            trailing: Text('\$${(stock['currentPrice'] * stock['shares']).toStringAsFixed(2)}'),
          ),
        )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: AspectRatio(
            aspectRatio: 1.7,
            child: _buildChart(),
          ),
        ),
      ],
    );
  }

  double _calculateTotalValue() {
    return _stockData.fold(0, (previousValue, element) => previousValue + (element['currentPrice'] * element['shares']));
  }

  Widget _buildChart() {
    List<PieChartSectionData> sections = _stockData.map((data) {
      final value = data['shares'] * data['currentPrice'];
      return PieChartSectionData(
        value: value,
        title: '${data['name']} \$${value.toStringAsFixed(0)}',
        color: Colors.primaries[_stockData.indexOf(data) % Colors.primaries.length],
        radius: 60,
        titleStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      );
    }).toList();

    return PieChart(
      PieChartData(
        sections: sections,
        sectionsSpace: 2,
        centerSpaceRadius: 30,
        pieTouchData: PieTouchData(
        ),
      ),
    );
  }
}
