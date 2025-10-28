// lib/screens/register_screen.dart
import 'package:flutter/material.dart';
import '../widgets/gradient_background.dart';
import 'package:parkeasy_app/backend/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final dniCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final tipoCtrl = TextEditingController();
  final placaCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final pass2Ctrl = TextEditingController();

  bool emailIsInstitutional(String email) {
    // Validación simple: contiene @ y dominio tecsup
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email) &&
        email.endsWith('@tecsup.edu.pe');
  }

  final authService = AuthService();

  void submit() async {
  if (!_formKey.currentState!.validate()) return;

  final error = await authService.registerUser(
    nombre: nameCtrl.text.trim(),
    dni: dniCtrl.text.trim(),
    correo: emailCtrl.text.trim(),
    tipoUsuario: tipoCtrl.text.trim(),
    placa: placaCtrl.text.trim(),
    contrasena: passCtrl.text.trim(),
  );

  if (error == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Registro exitoso. Verifique su correo.')),
    );
    Navigator.pushReplacementNamed(context, '/login');
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('❌ Error: $error')),
    );
  }
}

  @override
  void dispose() {
    nameCtrl.dispose();
    dniCtrl.dispose();
    emailCtrl.dispose();
    tipoCtrl.dispose();
    placaCtrl.dispose();
    passCtrl.dispose();
    pass2Ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 6),
                  Image.asset('assets/parkeasy_logo.jpg', width: 110),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: nameCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Nombres y apellidos',
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Ingrese su nombre'
                        : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: dniCtrl,
                    decoration: const InputDecoration(labelText: 'DNI'),
                    keyboardType: TextInputType.number,
                    validator: (v) => (v == null || v.trim().length < 6)
                        ? 'DNI inválido'
                        : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: emailCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Correo institucional',
                    ),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty)
                        return 'Ingrese correo';
                      if (!emailIsInstitutional(v.trim()))
                        return 'Use correo institucional (@tecsup.edu.pe)';
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: tipoCtrl,
                    decoration: const InputDecoration(
                      labelText:
                          'Tipo de usuario (estudiante/docente/seguridad)',
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Ingrese tipo de usuario'
                        : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: placaCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Placa del vehículo',
                    ),
                    validator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Ingrese placa'
                        : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: passCtrl,
                    decoration: const InputDecoration(labelText: 'Contraseña'),
                    obscureText: true,
                    validator: (v) => (v == null || v.length < 6)
                        ? 'Contraseña mínima 6 caracteres'
                        : null,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: pass2Ctrl,
                    decoration: const InputDecoration(
                      labelText: 'Confirmar contraseña',
                    ),
                    obscureText: true,
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Confirme contraseña';
                      if (v != passCtrl.text)
                        return 'Las contraseñas no coinciden';
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  ElevatedButton(
                    onPressed: submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E2A38),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('REGISTRAR'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
