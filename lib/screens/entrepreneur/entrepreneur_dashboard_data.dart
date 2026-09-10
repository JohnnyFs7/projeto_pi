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

  const List<ChartDataPoint> KChartData30 = [
    ChartDataPoint(day: 'S1', value:  1200),
    ChartDataPoint(day: 'S2', value:  1800),
    ChartDataPoint(day: 'S3', value:  1450),
    ChartDataPoint(day: 'S4', value:  2100),
  ];

  class UpcomingBooking {
    final int id;
    final String clientName;
    final String service;
    final String time;
    final String status;
    final String avatarUrl;

    const UpcomingBooking({
      required this.id,
      required this.clientName,
      required this.service,
      required this.time,
      required this.status,
      required this.avatarUrl,
  });
}

const List<UpcomingBooking> kUpcomingBookings = [
  UpcomingBooking(
    id: 1,
    clientName: 'Ana lima',
    service:  'Corte feminino',
    time:  '09:00',
    status: 'confirmed'
    avatarUrl: 'https://images.unsplash.com/photo-1769636929609-3d6b967b2f82?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=80',
  ),
    UpcomingBooking(
        id: 2,
        clientName: 'Carla Mendes',
        service: 'Coloração completa',
        time: '10:30',
        status: 'pending',
        avatarUrl: 'https://images.unsplash.com/photo-1769636929131-56dd60238266?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=80',
    ),
    UpcomingBooking(
        id: 3,
        clientName: 'Maria Santos',
        service: 'Hidratação',
        time: '14:00',
        status: '',
        avatarUrl: 'https://images.unsplash.com/photo-1771898343647-bd979ad8cca5?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&w=80',
    ),
  ];