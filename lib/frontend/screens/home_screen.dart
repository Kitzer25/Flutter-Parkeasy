// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Simulamos estado del aforo global y si el usuario tiene vehículo registrado
  int capacidadSotano = 110;
  int ocupadosSotano = 110; // prueba: lleno
  int capacidadSuperior = 12;
  int ocupadosSuperior = 8;

  // Simulación: en registro guardamos placa localmente (en real desde backend)
  String? placaRegistrada =
      'ABC-123'; // pon null para probar bloqueo si no tiene vehículo

  bool isFull() {
    // Si ambas zonas llenas -> no permitir
    return (ocupadosSotano >= capacidadSotano) &&
        (ocupadosSuperior >= capacidadSuperior);
  }

  void tryAccess() {
    if (placaRegistrada == null || placaRegistrada!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Debe registrar un vehículo para poder ingresar'),
        ),
      );
      return;
    }
    if (isFull()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aforo lleno. Contacte con el portero.')),
      );
      return;
    }

    // Simular la autorización por portero:
    // En producción -> enviar solicitud a backend y esperar respuesta (autorizado/denegado)
    setState(() {
      // disminuir en la zona que permitas (ejemplo: superior)
      if (ocupadosSuperior < capacidadSuperior) {
        ocupadosSuperior += 1;
      } else if (ocupadosSotano < capacidadSotano) {
        ocupadosSotano += 1;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ingreso autorizado (simulado). ¡Bienvenido!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalCapacidad = capacidadSotano + capacidadSuperior;
    final totalOcupados = ocupadosSotano + ocupadosSuperior;
    final disponibles = totalCapacidad - totalOcupados;

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/parkeasy_logo.jpg', width: 90),
                    TextButton(
                      onPressed: () {
                        // Cerrar sesion simulada -> volver a welcome
                        Navigator.pushReplacementNamed(context, '/');
                      },
                      child: const Text(
                        'Cerrar sesión',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Aforo actual: $disponibles / $totalCapacidad espacios disponibles',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sotano: $ocupadosSotano / $capacidadSotano  •  Superior: $ocupadosSuperior / $capacidadSuperior',
                ),
                const SizedBox(height: 18),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, '/map'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 124, 127, 131),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text('Ver Mapa de Estacionamiento'),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: tryAccess,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(
                      color: Color.fromARGB(255, 103, 105, 107),
                    ),
                    foregroundColor: const Color.fromARGB(255, 117, 119, 122),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text('Solicitar ingreso (pide autorización)'),
                ),
                const SizedBox(height: 18),
                Text('Placa registrada: ${placaRegistrada ?? "No registrada"}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
