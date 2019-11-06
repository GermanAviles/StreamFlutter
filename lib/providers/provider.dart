import 'package:flutter/material.dart';
import 'package:patronbloc/pages/login/login-bloc.dart';
export 'package:patronbloc/pages/login/login-bloc.dart';

class Provider extends InheritedWidget {

  static Provider _instancia;
  // Persistimos la data en el momento de hacer un hot-reload
  factory Provider({ Key key, Widget child }) {
    if ( _instancia == null ) {
      _instancia = new Provider._internal( key: key, child: child );
    }
    return _instancia;
  }

  // creamos la instancia de nuestro bloc 
  final loginBloc = LoginBloc();

  // inicializamos el constructor
  // Provider({ Key key, Widget child }) : super(key: key, child: child);
  Provider._internal({ Key key, Widget child }) : super(key: key, child: child);

  // actualizamos a todos los hijos cuando hayan cambios
  @override bool updateShouldNotify(InheritedWidget oldWidget) => true;

  // recuperamos el estado de nuestro bloc, en este caso el LoginBloc
  static LoginBloc of ( BuildContext context ) {
    // Tomamos el contexto (arbol de widget del proyecto) y buscamos exactamente el widget tipo "Provider"
    return ( context.inheritFromWidgetOfExactType( Provider ) as Provider ).loginBloc;
  }
  
}