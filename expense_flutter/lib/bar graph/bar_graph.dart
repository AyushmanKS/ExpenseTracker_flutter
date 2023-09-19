import 'package:expense_flutter/bar%20graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:expense_flutter/components/animated_styles.dart';

// ignore: must_be_immutable
class MyBarGraph extends StatelessWidget {
  double maxY;

  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;

// constructor
  MyBarGraph({
    super.key,
    required this.maxY,
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thuAmount,
    required this.friAmount,
    required this.satAmount,
  });

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
        sunAmount: sunAmount,
        monAmount: monAmount,
        tueAmount: tueAmount,
        wedAmount: wedAmount,
        thuAmount: thuAmount,
        friAmount: friAmount,
        satAmount: satAmount);

    myBarData.initializeBarData();

    return BarChart(
      BarChartData(
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTitles,
            ),
          ),
        ),
        maxY: maxY,
        minY: 0,
        barGroups: myBarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    // active bar color
                    color: Colors.black,
                    width: 22,
                    borderRadius: BorderRadius.circular(5),
                    backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: maxY,
                        // background bar color
                        color: Colors.white),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

// BottomTiles Text {su,mo,tu,we......sa}
Widget getBottomTitles(double value, TitleMeta meta) {
  //const style = TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13.5);

  late Widget text;

  switch (value.toInt()) {
    case 0:
      text = BottomTitlesStyle(dayName: 'Su');
      break;
    case 1:
      text = BottomTitlesStyle(dayName: 'Mo');
      break;
    case 2:
      text = BottomTitlesStyle(dayName: 'Tu');
      break;
    case 3:
      text = BottomTitlesStyle(dayName: 'We');
    case 4:
      text = BottomTitlesStyle(dayName: 'Th');
      break;
    case 5:
      text = BottomTitlesStyle(dayName: 'Fr');
      break;
    case 6:
      text = BottomTitlesStyle(dayName: 'Sa');
      break;
    default:
      const Text(' ');
      break;
  }
  return SideTitleWidget(axisSide: meta.axisSide, child: text);
}
