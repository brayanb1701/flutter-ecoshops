import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/services/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:provider/provider.dart';
import 'register_entrepreneurship.dart';

class UserForm extends FormBloc<String, String> {
  final select1 = SelectFieldBloc(
    name: 'gender',
    items: ['Masculino', 'Femenino', 'Otro'],
  );

  final text1 = TextFieldBloc(
    name: 'full_name',
    validators: [FieldBlocValidators.required],
  );

  final text2 = TextFieldBloc(
    name: 'address',
    validators: [FieldBlocValidators.required],
  );

  final text3 = TextFieldBloc(
    name: 'phone',
    validators: [FieldBlocValidators.required],
  );

  final date1 = InputFieldBloc<DateTime, dynamic>(
      name: 'birth_date', toJson: (value) => Timestamp.fromDate(value!));

  late AuthService authServices;

  UserForm(AuthService auth) {
    authServices = auth;
    text1.updateInitialValue(authServices.currentUser.fullName);
    select1.updateInitialValue(authServices.currentUser.gender);
    text2.updateInitialValue(authServices.currentUser.address);
    text3.updateInitialValue(authServices.currentUser.phone.toString());
    date1.updateInitialValue(authServices.currentUser.birthDate);

    addFieldBlocs(fieldBlocs: [
      text1,
      text2,
      text3,
      date1,
      select1,
    ]);
  }

  @override
  Future<void> close() {
    return super.close();
  }

  @override
  void onSubmitting() async {
    try {
      var updates = state.toJson();
      print(updates);
      updates['phone'] = int.parse(updates['phone']);
      print(updates);
      await authServices.updateUser(updates);

      emitSuccess(canSubmitAgain: true);
    } catch (e) {
      print(e);
      print(e.toString());
      emitFailure();
    }
  }
}

class UpdateUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthService>(context);
    return BlocProvider(
      create: (BuildContext context) => UserForm(authServices),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<UserForm>(context);

          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Scaffold(
              appBar: AppBar(
                title: Text('Mi perfil', style: TextStyle(color: Colors.black)),
                backgroundColor: Colors.lightGreen,
              ),
              body: FormBlocListener<UserForm, String, String>(
                onSubmitting: (context, state) {
                  LoadingDialog.show(context);
                },
                onSuccess: (context, state) {
                  LoadingDialog.hide(context);

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "Los datos de usuario fueron actualizados correctamente."),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.lightGreen,
                  ));
                },
                onFailure: (context, state) {
                  LoadingDialog.hide(context);

                  print(state.failureResponse);
                },
                child: SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.text1,
                          decoration: InputDecoration(
                            labelText: 'Nombre',
                            prefixIcon: Icon(Icons.text_fields),
                          ),
                        ),
                        RadioButtonGroupFieldBlocBuilder<String>(
                          selectFieldBloc: formBloc.select1,
                          decoration: InputDecoration(
                            labelText: 'Género',
                            prefixIcon: SizedBox(),
                          ),
                          itemBuilder: (context, item) => item,
                        ),
                        TextFieldBlocBuilder(
                          textFieldBloc: formBloc.text2,
                          decoration: InputDecoration(
                            labelText: 'Dirección',
                            prefixIcon: Icon(Icons.maps_home_work_outlined),
                          ),
                        ),
                        TextFieldBlocBuilder(
                          keyboardType: TextInputType.phone,
                          textFieldBloc: formBloc.text3,
                          decoration: InputDecoration(
                            labelText: 'Celular',
                            prefixIcon: Icon(Icons.phone_android_rounded),
                          ),
                        ),
                        DateTimeFieldBlocBuilder(
                          dateTimeFieldBloc: formBloc.date1,
                          format: DateFormat('dd-MM-yyyy'),
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                          decoration: InputDecoration(
                            labelText: 'Fecha de Nacimiento',
                            prefixIcon: Icon(Icons.cake),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.lightGreen),
                          onPressed: formBloc.submit,
                          child: Text('Actualizar'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
