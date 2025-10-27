import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFcfd3d8),
      appBar: AppBar(
        title: const Text('Estacionamientos'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 106, 109, 112),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Estacionamiento P1'),
            const SizedBox(height: 10),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: 50,
                      color: Colors.orange,
                      title: 'Autos',
                    ),
                    PieChartSectionData(
                      value: 30,
                      color: Colors.blue,
                      title: 'Camionetas',
                    ),
                    PieChartSectionData(
                      value: 20,
                      color: Colors.green,
                      title: 'Motos',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Estacionamiento P2'),
            const SizedBox(height: 10),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: 60,
                      color: Colors.orange,
                      title: 'Autos',
                    ),
                    PieChartSectionData(
                      value: 40,
                      color: Colors.blue,
                      title: 'Camionetas',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
