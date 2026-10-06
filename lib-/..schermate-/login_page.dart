import 'package:flutter/material.dart';
import '../servizi/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();

  bool _registrazione = false;
  bool _caricamento = false;
  String? _errore;

  Future<void> _entra() async {
    setState(() {
      _caricamento = true;
      _errore = null;
    });

    try {
      if (_registrazione) {
        await _authService.register(
          email: _emailController.text,
          password: _passwordController.text,
        );
      } else {
        await _authService.login(
          email: _emailController.text,
          password: _passwordController.text,
        );
      }
    } catch (e) {
      setState(() {
        _errore = 'Accesso non riuscito. Controlla email e password.';
      });
    } finally {
      if (mounted) {
        setState(() => _caricamento = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Icon(
                  Icons.sports_soccer,
                  size: 90,
                  color: Colors.green,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Young Football',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'La community dei giovani calciatori',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 35),

                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height:
