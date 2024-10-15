import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      mainBarData(),
    );
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x, 
      barRods: [
        BarChartRodData(
          toY: y,
          width: 15,
          gradient: LinearGradient(
            colors: [
            Theme.of(context).colorScheme.tertiary,
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.primary,
          ],
          transform: const GradientRotation(pi/40)
          ),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 5,
            color: Colors.grey.shade300,
          ),
          
        ),
      ]
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(8, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 2);
          case 1:
            return makeGroupData(1, 3);
          case 2:
            return makeGroupData(2, 2);
          case 3:
            return makeGroupData(3, 4.5);
          case 4:
            return makeGroupData(4, 1.5);
          case 5:
            return makeGroupData(5, 4);
          case 6:
            return makeGroupData(6, 4);
          case 7:
            return makeGroupData(7, 3.4);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
                showTitles: true, reservedSize: 38, getTitlesWidget: getTiles),
          ),
          leftTitles: AxisTitles(
            sideTitles:
                SideTitles(showTitles: true,
                reservedSize: 38, getTitlesWidget: leftTitles),
          ),
        ),
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: false),
        barGroups: showingGroups());
  }

  Widget getTiles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: CupertinoColors.systemGrey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget title;
    switch (value.toInt()) {
      case 0:
        title = const Text('01', style: style);
        break;
      case 1:
        title = const Text('02', style: style);
        break;
      case 2:
        title = const Text('03', style: style);
        break;
      case 3:
        title = const Text('04', style: style);
        break;
      case 4:
        title = const Text('05', style: style);
        break;
      case 5:
        title = const Text('06', style: style);
        break;
      case 6:
        title = const Text('07', style: style);
        break;
      case 7:
        title = const Text('08', style: style);
        break;
      case 8:
        title = const Text('09', style: style);
        break;
      case 9:
        title = const Text('10', style: style);
        break;
      case 10:
        title = const Text('11', style: style);
        break;

      default:
        title = const Text('', style: style);
        break;
    }
    return SideTitleWidget(child: title, axisSide: meta.axisSide, space: 16);
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: CupertinoColors.systemGrey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String title;
    if (value == 0) {
      title = '1K';
    } else if (value == 1) {
      title = '2K';
    } else if (value == 2) {
      title = '3K';
    } else if (value == 3) {
      title = '4K';
    } else if (value == 4) {
      title = '5K';
    } else if (value == 5) {
      title = '6K';
    } else if (value == 6) {
      title = '7K';
    } else if (value == 7) {
      title = '8K';
    } else if (value == 8) {
      title = '9K';
    } else {
      return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(title, style: style),
    );
  }
}
