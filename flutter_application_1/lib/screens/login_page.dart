import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //evita que se quite espacio de la camara frontal
      body: SafeArea(child: Column(
        children:[Expanded(child:)]
      )
      )
    );
  }
}