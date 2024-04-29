import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

class ScreenTwo extends StatefulWidget {
  @override
  _ScreenTwoState createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  late List<double> _forecastPrices = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _fetchForecastData(String ticker) async {
    final url = 'https://predictotron-ozt63nqmpa-nw.a.run.app/load_predict?ticker=$ticker';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      List<double> forecastPrices = List<double>.from(jsonData['predicted_prices'].map((model) => model as double));
      setState(() {
        _forecastPrices = forecastPrices;
      });
    } else {
      throw Exception('Failed to load forecast data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Analytics'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              if (_searchController.text.isNotEmpty) {
                _fetchForecastData(_searchController.text);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  labelText: 'Search Stocks',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    _fetchForecastData(value);
                  }
                },
              ),
            ),
            ChartSection(
                title: 'Forecasted Stock Values',
                chartWidget: _forecastPrices.isEmpty
                    ? CircularProgressIndicator()
                    : ForecastChart(forecastPrices: _forecastPrices)),
          ],
        ),
      ),
    );
  }
}

class ChartSection extends StatelessWidget {
  final String title;
  final Widget chartWidget;

  const ChartSection({Key? key, required this.title, required this.chartWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Container(
              height: 200, // Fixed height for simplicity
              child: chartWidget,
            ),
          ],
        ),
      ),
    );
  }
}

class ForecastChart extends StatelessWidget {
  final List<double> forecastPrices;

  const ForecastChart({Key? key, required this.forecastPrices}) : super(key: key);

  List<FlSpot> _getSpots() {
    List<FlSpot> spots = [];
    for (int i = 0; i < forecastPrices.length; i++) {
      spots.add(FlSpot(i.toDouble(), forecastPrices[i]));
    }
    return spots;
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
        LineChartData(
          minX: 0,
          maxX: forecastPrices.length.toDouble() - 1,
          minY: forecastPrices.reduce(min),
          maxY: forecastPrices.reduce(max),
          lineBarsData: [
            LineChartBarData(
              spots: _getSpots(),
              isCurved: true,
              barWidth: 2,
              color: Colors.blue,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          ],
          titlesData: FlTitlesData(show: false),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: const Color(0xff37434d), width: 1),
          ),
        )
    );
  }
}
