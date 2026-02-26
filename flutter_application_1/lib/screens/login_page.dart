import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'dart:async';//3.1 importa el timer

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // Control para mostrar/ocultar la contraseña
  bool _obscureText = true;

  //Crear el cerebro de la animación
  StateMachineController? _controller;
  //SMI: State Machine Input
  SMIBool? _isChecking;
  SMIBool? _isHandsUp;
  SMIBool? _trigSuccess;
  SMIBool? _trigFail;

  //2.1 variable para el recorido de la mirada
  SMINumber? _numLook;

  //1) CREAR VARIABLES PARA FOCUSnode
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  //3.2) variable para detener la mirada al dejar de escirbir
  Timer? _typingDebounce;


  //2) listeners para focusnode (oyentes o los chismosos)
  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (_emailFocusNode.hasFocus) {
          if(_isHandsUp != null){
            _isHandsUp!.change(false);
            //2.2 asignar
            _numLook?.value = 50.0;
          }
      }
    });
    _passwordFocusNode.addListener((){
      _isHandsUp?.change(_passwordFocusNode.hasFocus);
    });
  }
  

  @override
  Widget build(BuildContext context) {
    // Para obtener el tamaño de la pantalla
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        // Evita que el contenido se superponga con el notch
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(
                width:size.width,
                height:200,
                child: RiveAnimation.asset(
                  'assets/animated_login_bear.riv',
                  stateMachines: ['Login Machine'],
                  //Al inciar la anaimación
                  onInit: (artboard){
                    _controller = StateMachineController.fromArtboard(artboard, 
                    'Login Machine',
                    );

                    //Verifica que inició bien
                    if (_controller == null) return;
                    //Agrega el controlador al tablero/escenario
                    artboard.addController(_controller!);
                    //Vincular variables
                    _isChecking = _controller!.findSMI('isChecking');
                    _isHandsUp = _controller!.findSMI('isHandsUp');
                    _trigSuccess = _controller!.findSMI('trigSuccess');
                    _trigFail = _controller!.findSMI('trigFail');
                    //2.3 vincular variable para el recorrido de la mirada
                    _numLook = _controller!.findSMI('numLook');
                  },
                  )
                ),
              // Para separación
              const SizedBox(height: 10),
              //textfield para email
              TextField(
                //1.3 asignar focusnode a textfield
                focusNode: _emailFocusNode,
                onChanged:(value) {
                  if (_isHandsUp != null){
                     //_isHandsUp!.change(false);


                }
                if (_isChecking == null ) return;
                 _isChecking!.change(true);
                 //2.4 implementar numLook para el recorrido de la mirada
                 //ajustes de limite de 0 a 100
                 //80 como medida de calibracion
                  final look = (value.length / 80.0 * 100)
                  .clamp(0.0, 100.0);//limita el rango(abrazadera)
                  _numLook?.value = look;

                //3.3 Debounce si vuelve a teclear reinicia el contador
                //cancelar cualquier timer activo
                _typingDebounce?.cancel();
                _typingDebounce = Timer(
                  const Duration(seconds: 3), () {
                    //si se cierra la pantalla, quita el contador
                    if (!mounted) return;
                     //mirada neutra
                     _isChecking?.change(false);
                    //Timer
                    
                  }
                );

                 
                },
                decoration: InputDecoration(
                  hintText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    // Para redondear los bordes
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                //1.3 asignar focusnode a textfield de password
                focusNode: _passwordFocusNode,
                onChanged:(value) {
                  if (_isChecking != null){
                     //_isChecking!.change(false);

                }
                if (_isHandsUp == null ) return;
                 _isHandsUp!.change(true);
 

                },
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      //Refresca el icono
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  //1.4 liberar recursos al salir de la pantalla
  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _typingDebounce?.cancel();
    super.dispose();
  }
}