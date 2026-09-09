import 'package:flutter/material.dart';

  class ChartDataPoint {
    final String day;
    final double value,

    ChartDataPoint({required this.day, required this.value});
  }

  const List<ChartDataPoint> kChartData7 = [
    ChartDataPoint(day: 'Seg', value: 120),
    ChartDataPoint(day: 'Ter', value: 280),
    ChartDataPoint(day: 'Qua', value: 190),
    ChartDataPoint(day: 'Qui', value: 340),
    ChartDataPoint(day: 'Sex', value: 420),
    ChartDataPoint(day: 'Sáb', value: 380),
    ChartDataPoint(day: 'Dom', value: 90),
  ];

  const List<ChartDataPoint> KChart