import 'package:coivd_19/View/World_State.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class detailScreen extends StatefulWidget {
  String image, name;
  int totalCase,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecoverd,
      test;
  detailScreen(
      {required this.image,
      required this.name,
      required this.totalCase,
      required this.totalDeaths,
      required this.totalRecovered,
      required this.active,
      required this.critical,
      required this.todayRecoverd,
      required this.test});
  @override
  State<detailScreen> createState() => _detailScreenState();
}

class _detailScreenState extends State<detailScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  void disposed() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa268),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff1aa268),
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PieChart(
            dataMap: {
              'Total': double.parse(widget.totalCase.toString()),
              'Recoverd': double.parse(widget.totalRecovered.toString()),
              'Deths': double.parse(widget.totalDeaths.toString()),
            },
            chartValuesOptions: const ChartValuesOptions(
              showChartValuesInPercentage: true,
            ),
            chartRadius: MediaQuery.of(context).size.width / 5.2,
            legendOptions:
                const LegendOptions(legendPosition: LegendPosition.left),
            animationDuration: const Duration(seconds: 1),
            chartType: ChartType.ring,
            colorList: colorList,
          ),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .07),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .06,
                      ),
                      ReusableWidget(
                          title: 'Cases', value: widget.totalCase.toString()),
                      ReusableWidget(
                          title: 'Recovered',
                          value: widget.totalRecovered.toString()),
                      ReusableWidget(
                          title: 'Death', value: widget.totalDeaths.toString()),
                      ReusableWidget(
                          title: 'Critical', value: widget.critical.toString()),
                      ReusableWidget(
                          title: 'Today Revocerd',
                          value: widget.todayRecoverd.toString()),
                      ReusableWidget(
                          title: 'Active', value: widget.active.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          ),
        ],
      ),
    );
  }
}
