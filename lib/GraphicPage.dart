import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphicPage extends StatefulWidget {
  @override
  _GraphicPageState createState() => _GraphicPageState();
}

class _GraphicPageState extends State<GraphicPage> {
  List<PieSegment> pieData = [];
  List<TimeSeriesSales> lineData = [];

  @override
  void initState() {
    super.initState();
    pieData = _createPieData();
    lineData = _createLineData();
  }

  List<PieSegment> _createPieData() {
    return [
      PieSegment('Büyükbaş', 40, Colors.blue),
      PieSegment('Küçükbaş', 30, Colors.green),
      PieSegment('Boş 1', 20, Colors.red),
      PieSegment('Boş 2', 10, Colors.yellow),
    ];
  }

  List<TimeSeriesSales> _createLineData() {
    return [
      TimeSeriesSales(DateTime(2022, 1, 1), 5),
      TimeSeriesSales(DateTime(2022, 2, 1), 25),
      TimeSeriesSales(DateTime(2022, 3, 1), 100),
      TimeSeriesSales(DateTime(2022, 4, 1), 75),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 60.0),
            child: Container(
              height: 40,
              width: 130,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('resimler/logo_v2.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Hayvanlarınız',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                height: 330,
                child: SfCircularChart(
                  legend: Legend(
                      isVisible: true
                  ),
                  series: <CircularSeries>[
                    PieSeries<PieSegment, String>(
                      dataSource: pieData,
                      xValueMapper: (PieSegment data, _) => data.segment,
                      yValueMapper: (PieSegment data, _) => data.size,
                      dataLabelMapper: (PieSegment data, _) =>
                      '${(data.size / pieData.fold(0, (prev, element) => prev + element.size) * 100).toStringAsFixed(1)}%',
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        labelPosition: ChartDataLabelPosition.inside,
                        textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      animationDuration: 2000,
                    ),
                  ],
                ),
              ),
              Text(
                'Eklenen Hayvanlar',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                height: 300,
                child: SfCartesianChart(
                  primaryXAxis: DateTimeAxis(),
                  series: <CartesianSeries>[
                    LineSeries<TimeSeriesSales, DateTime>(
                      dataSource: lineData,
                      xValueMapper: (TimeSeriesSales sales, _) => sales.time,
                      yValueMapper: (TimeSeriesSales sales, _) => sales.sales,
                      animationDuration: 2000,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PieSegment {
  final String segment;
  final int size;
  final Color color;

  PieSegment(this.segment, this.size, this.color);
}

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}