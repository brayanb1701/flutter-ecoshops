import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/palette.dart';
import 'package:flutter_ecoshops/services/auth_service.dart';
import 'package:flutter_ecoshops/widgets/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authServices = Provider.of<AuthService>(context);

    return Stack(
      children: [
        BackgroundImage(image: 'assets/bg.jpg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: kWhite,
              ),
            ),
            title: Text(
              'Registro',
              style: kBodyText,
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.width * 0.06,
                ),
                Stack(
                  children: [
                    Center(
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: CircleAvatar(
                            radius: size.width * 0.14,
                            backgroundColor: Colors.grey[400]?.withOpacity(
                              0.4,
                            ),
                            child: Icon(
                              FontAwesomeIcons.user,
                              color: kWhite,
                              size: size.width * 0.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.08,
                      left: size.width * 0.56,
                      child: Container(
                        height: size.width * 0.1,
                        width: size.width * 0.1,
                        decoration: BoxDecoration(
                          color: kBlue,
                          shape: BoxShape.circle,
                          border: Border.all(color: kWhite, width: 2),
                        ),
                        child: Icon(
                          FontAwesomeIcons.arrowUp,
                          color: kWhite,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: size.width * 0.06,
                ),
                Column(
                  children: [
                    TextInputField(
                      icon: FontAwesomeIcons.user,
                      hint: 'Nombre',
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      onChanged: (value) {
                        //userServices.currentUser.fullName = value;
                        authServices.currentUser.fullName = value;
                      },
                    ),
                    TextInputField(
                      icon: FontAwesomeIcons.envelope,
                      hint: 'Correo',
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                      onChanged: (value) {
                        //userServices.currentUser.mail = value;
                        authServices.currentUser.mail = value;
                      },
                    ),
                    PasswordInput(
                      icon: FontAwesomeIcons.lock,
                      hint: 'Contraseña',
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      onChanged: (value) {
                        //userServices.currentUser.password = value;
                        authServices.currentUser.password = value;
                      },
                    ),
                    /*PasswordInput(
                      icon: FontAwesomeIcons.lock,
                      hint: 'Confirmar contraseña',
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.done,
                    ),*/
                    SizedBox(
                      height: 25,
                    ),
                    RoundedButton(
                      buttonName: 'Registrarse',
                      onPressed: () async {
                        print('Nombre: ${authServices.currentUser.fullName}');
                        print('Email: ${authServices.currentUser.mail}');
                        print('Clave: ${authServices.currentUser.password}');
                        await authServices.createAccount(context);
                        Navigator.pushNamed(context, 'login');
                        print("Usuario Creado");
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '¿Ya tiene una cuenta?',
                          style: kBodyText,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, 'login');
                          },
                          child: Text(
                            ' Iniciar Sesión',
                            style: kBodyText.copyWith(
                              color: Colors.lightGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
