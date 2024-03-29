import 'package:flutter/material.dart';
import 'package:patronbloc/providers/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: <Widget>[
            _crearFondo( context ),
            _loginForm( context ),
          ],
      )
    );
  }

  /* ... Metodo para crear el cajon del formulario ... */  
  Widget _loginForm ( BuildContext context ) {
    
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;


    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),

          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric( vertical: 30.0 ),
            padding: EdgeInsets.symmetric( vertical: 50.0 ),
            decoration: BoxDecoration( 
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0
                ),
              ]
            ),
            child: Column(
              children: <Widget>[
                Text('Ingreso', style: TextStyle(fontSize: 20.0)),
                SizedBox( height: 60.0 ),
                _crearEmail( bloc ),
                SizedBox( height: 30.0 ),
                _crearPassword( bloc ),
                SizedBox( height: 30.0 ),
                _crearBoton( bloc )
              ],
            ),
          ),
          Text('¿Olvidó la contraseña?'),
          SizedBox(height: 100.0)
        ],
      ),
    );
  }

  /* ... Metodo para crear el fondo (gradiente) morado con burbujas ... */
  Widget _crearFondo( BuildContext context ) {

    // media query para obtener el tamaño de la pantalla
    final size = MediaQuery.of(context).size;

    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color> [
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0),
          ]
        )
      ),
    );

    final burbujas = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.06)
      ),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned(top: 90.0, left: 30.0, child: burbujas),
        Positioned(top: -40.0, right: -30.0, child: burbujas),
        Positioned(top: 10.0, left: 90.0, child: burbujas),
        Positioned(bottom: -50.0, right: -10.0, child: burbujas),
        Positioned(bottom: 49.0, right: 90.0, child: burbujas),
        Positioned(bottom: -50.0, left: -30.0, child: burbujas),

        Container(
          padding: EdgeInsets.only( top: 80.0 ),
          child: Column(
            children: <Widget>[
              Icon( Icons.settings, color: Colors.white, size: 100.0),
              SizedBox(height: 10.0, width: double.infinity),
              Text('PATRÓN BLOC', style: TextStyle( color: Colors.white, fontSize: 25.0 ),)
            ],
          ),
        )
      ],
    );
  }

  /* ... Metodo para crear el campo del email ... */
  Widget _crearEmail( LoginBloc bloc ) {

    return StreamBuilder(
      stream: bloc.emailStream,

      builder: ( BuildContext context, AsyncSnapshot snapshot ){
        return Container(
          padding: EdgeInsets.symmetric( horizontal: 20.0 ),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon( Icons.alternate_email, color: Colors.deepPurple ),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo electrónico',
              counterText: snapshot?.data,
              errorText: snapshot?.error
            ),
            onChanged: ( value ) => bloc.emailSink( value ),
          ),
        );
      },
    );
  
  }

  /* ... Metodo para crear el campo de la contraseña ... */
  Widget _crearPassword( LoginBloc bloc ) {

    return StreamBuilder(
      stream: bloc.passwStream,

      builder: ( BuildContext context, AsyncSnapshot snapshot ){
        return Container(
          padding: EdgeInsets.symmetric( horizontal: 20.0 ),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon( Icons.lock_outline, color: Colors.deepPurple ),
              labelText: 'Contraseña',
              errorText: snapshot?.error
            ),
            onChanged: (value) => bloc.passwSink( value ),
          ),
        );
      },
    );
    
  }

  /* ... Metodo para crear el botón de ingresar ... */
  Widget _crearBoton( LoginBloc bloc ) {

    return StreamBuilder(
      stream: bloc.formValidStream,

      builder: ( BuildContext context, AsyncSnapshot snapshot) {

        return RaisedButton(
          padding: EdgeInsets.symmetric( horizontal: 80.0, vertical: 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 0.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          child: Container(
            child: Text('Ingresar'),
          ),
          onPressed: snapshot.hasData ? () => _iniciarSesion( context ) : null,
        );
      },
    );

  }
  _iniciarSesion( BuildContext context ) {
    Navigator.pushReplacementNamed(context, 'home');
  }

}