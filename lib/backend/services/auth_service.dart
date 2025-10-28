// lib/backend/services/auth_service.dart
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class AuthService {
  const AuthService();

  Future<String?> registerUser({
    required String nombre,
    required String dni,
    required String correo,
    required String tipoUsuario,
    required String placa,
    required String contrasena,
  }) async {
    try {
      if (!correo.endsWith('@tecsup.edu.pe')) {
        return 'Use correo institucional (@tecsup.edu.pe)';
      }
      if (dni.length != 8) {
        return 'El DNI debe tener 8 dígitos';
      }

      final existing = await supabase
          .from('credenciales')
          .select()
          .eq('correo', correo)
          .maybeSingle();

      if (existing != null) {
        return 'Correo ya registrado';
      }

      final tipo = correo.endsWith('@tecsup.edu.pe') ? 'Tecsup' : 'Invitado';

      const rol = 'Conductor';

      final credencial = await supabase.from('credenciales').insert({
        'correo': correo,
        'contrasena': contrasena,
        'tipo': tipo,
        'proveedor': 'Local',
        'rol': rol,
      }).select().single();

      await supabase.from('conductores').insert({
        'dni': dni,
        'nombre': nombre,
        'apellido': '',
        'sexo': '',
        'id_credencial': credencial['id_credencial'],
        'registrado': true,
        'placa': placa,
        'tipo_usuario': tipoUsuario,
      });

      await supabase.auth.signUp(
        email: correo,
        password: contrasena,
      );

      return null; // éxito
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return 'Error inesperado: $e';
    }
  }

  Future<String?> loginUser({
    required String correo,
    required String contrasena,
  }) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: correo,
        password: contrasena,
      );

      final session = response.session;
      if (session == null) return 'Credenciales incorrectas';

      return null; // éxito
    } on AuthException catch (e) {
      return e.message;
    } catch (e) {
      return 'Error inesperado: $e';
    }
  }

  bool validarToken() {
    final session = supabase.auth.currentSession;
    if (session == null) return false;
    return session.expiresAt == null
        ? true
        : (DateTime.now().millisecondsSinceEpoch / 1000) < session.expiresAt!;
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
  }
}
