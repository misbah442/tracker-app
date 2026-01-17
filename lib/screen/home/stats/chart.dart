import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyChart extends StatefulWidget {
  const MyChart({super.key});

  @override
  State<MyChart> createState() => _ChartState();
}

class _ChartState extends State<MyChart> {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      mainBarData(),

      ///call the function here
    );
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          width: 10,
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.tertiary,
            ],
            transform: GradientRotation(pi / 30),
          ),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 5,
            color: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(8, (i) {
    switch (i) {
      case 0:
        return makeGroupData(0, 2);

      case 1:
        return makeGroupData(1, 3);
      case 2:
        return makeGroupData(2, 1.4);
      case 3:
        return makeGroupData(3, 3.3);
      case 4:
        return makeGroupData(4, 2.1);
      case 5:
        return makeGroupData(5, 4.0);
      case 6:
        return makeGroupData(6, 2.3);
      case 7:
        return makeGroupData(7, 3);
      default:
        return throw Error();
    }
  });

  BarChartData mainBarData() {
    // define the function here
    return BarChartData(
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 38,
            getTitlesWidget: getTiles, // call the function as a value
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 38,
            interval: 0.5,
            getTitlesWidget: leftTiles,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      gridData: FlGridData(show: false),
      barGroups: showingGroups(), // call the function
    );
  }

  Widget getTiles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;

    switch (value.toInt()) {
      case 0:
        text = Text("01", style: style);
        break;
      case 1:
        text = Text("02", style: style);
        break;
      case 2:
        text = Text("03", style: style);
        break;
      case 3:
        text = Text("04", style: style);
        break;
      case 4:
        text = Text("05", style: style);
        break;
      case 5:
        text = Text("06", style: style);
        break;
      case 6:
        text = Text("07", style: style);
        break;
      case 7:
        text = Text("08", style: style);
        break;
      case 8:
        text = Text("09", style: style);
        break;
      default:
        text = Text("", style: style);
        break;
    }

    return SideTitleWidget(child: text, meta: meta, space: 13);
  }

  Widget leftTiles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );
    String text;
    if (value == 0) {
      text = "1k";
    } else if (value == 1) {
      text = "2k";
    } else if (value == 2) {
      text = "3k";
    } else if (value == 3) {
      text = "4k";
    } else if (value == 4) {
      text = "5k";
    } else {
      return Container();
    }

    return SideTitleWidget(
      meta: meta, // ✅ REQUIRED
      space: 10,
      child: Text(text, style: style),
    );
  }
}
