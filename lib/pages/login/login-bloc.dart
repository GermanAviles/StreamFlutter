
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:patronbloc/utils/validators.dart';

class LoginBloc with Validators{

  final _emailController    = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();  

  // final _emailController    = StreamController<String>.broadcast();
  // final _passwordController = StreamController<String>.broadcast();  

  // Salida del stream
  Stream<String> get emailStream => _emailController.stream.transform( validarEmail );
  Stream<String> get passwStream => _passwordController.stream.transform( validarPassword );

  Stream<bool> get formValidStream => Observable.combineLatest2(emailStream, passwStream, (e, p) => true);

  // agregar valores al stream
  Function(String) get emailSink => _emailController.sink.add;
  Function(String) get passwSink => _passwordController.sink.add;

  // cerramos la conexión con los stream
  void dispose() {
    _emailController?.close();
    _passwordController?.close();
  }

}