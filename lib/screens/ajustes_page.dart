import 'package:flutter/material.dart';
import '../models/usuario_model.dart';
import '../database/local_database.dart';

class AjustesPage extends StatefulWidget {
  const AjustesPage({super.key});

  @override
  State<AjustesPage> createState() => _AjustesPageState();
}

class _AjustesPageState extends State<AjustesPage> {
  @override
  Widget build(BuildContext context) {
    bool estaLogueado = LocalDatabase.usuarioLogueado != null;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text('Ajustes', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 38,
                  backgroundColor: const Color(0xFF8B5CF6).withOpacity(0.15),
                  child: Icon(
                    estaLogueado ? Icons.person_rounded : Icons.person_outline_rounded, 
                    size: 36, 
                    color: const Color(0xFF8B5CF6)
                  ),
                ),
                const SizedBox(height: 12),
                Text(estaLogueado ? LocalDatabase.usuarioLogueado!.username : 'Invitado', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(estaLogueado ? LocalDatabase.usuarioLogueado!.email : 'Inicia sesión para guardar datos', style: const TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Text('Autenticación', style: TextStyle(color: Colors.white38, fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          
          // Botón Iniciar Sesión
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF12141C),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              enabled: !estaLogueado,
              onTap: () {
                setState(() {
                  LocalDatabase.usuarioLogueado = UsuarioModel(
                    username: 'Ángel Moreno',
                    email: 'angel.moreno@skycast.com',
                    token: 'mock_jwt_token_spring_boot_12345',
                  );
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sesión Iniciada (Datos cargados en memoria).')),
                );
              },
              leading: Icon(Icons.login_rounded, color: !estaLogueado ? Colors.greenAccent : Colors.grey, size: 20),
              title: const Text('Iniciar Sesión', style: TextStyle(fontSize: 14)),
            ),
          ),
          const SizedBox(height: 12),

          // Botón Cerrar Sesión
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF12141C),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              enabled: estaLogueado,
              onTap: () {
                setState(() {
                  LocalDatabase.usuarioLogueado = null;
                  LocalDatabase.listaFavoritos.clear();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sesión Cerrada. Memorias locales reiniciadas.')),
                );
              },
              leading: Icon(Icons.logout_rounded, color: estaLogueado ? Colors.redAccent : Colors.grey, size: 20),
              title: const Text('Cerrar Sesión', style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
    );
  }
}
