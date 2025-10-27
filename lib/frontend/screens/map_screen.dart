// lib/screens/map_screen.dart
import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Simulación de aforo: sotano 110 plazas, superior 12 plazas
  // Aquí representamos un array con true = ocupado, false = libre
  List<bool> sotano = List<bool>.generate(
    24,
    (i) => i < 10,
  ); // ejemplo visual 24
  List<bool> superior = List<bool>.generate(12, (i) => i % 3 == 0); // ejemplo

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Estacionamiento'),
        backgroundColor: const Color.fromARGB(255, 126, 128, 129),
      ),
      body: GradientBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionTitle('Sótano (capacidad visual: ${sotano.length})'),
              const SizedBox(height: 8),
              buildGrid(sotano, rows: 6),
              const SizedBox(height: 20),
              sectionTitle('Superior (capacidad visual: ${superior.length})'),
              const SizedBox(height: 8),
              buildGrid(superior, rows: 3),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // En versión real: refrescar desde API
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Datos actualizados (simulado)'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E2A38),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                  ),
                  child: const Text('Actualizar estado'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String t) => Text(
    t,
    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  );

  Widget buildGrid(List<bool> arr, {int rows = 4}) {
    int cols = (arr.length / rows).ceil();
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: arr.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cols,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1.3,
      ),
      itemBuilder: (context, idx) {
        final occupied = arr[idx];
        return GestureDetector(
          onTap: () {
            // Para pruebas, permitir alternar (en producción solo admin)
            setState(() {
              arr[idx] = !arr[idx];
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: occupied ? Colors.red.shade400 : Colors.green.shade300,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black12),
            ),
            child: Center(
              child: Text(
                'P${idx + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
