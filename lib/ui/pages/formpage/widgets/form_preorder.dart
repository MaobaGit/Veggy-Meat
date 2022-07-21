import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:veggy/router/navigation_key.dart';
import 'package:veggy/router/routes.dart';
import 'package:veggy/theme/colors.dart';
import 'package:veggy/ui/ShoppingCartCubit/shoppingcart_cubit.dart';
import 'package:veggy/ui/pages/formpage/formCubit/form_cubit.dart';
import 'package:veggy/ui/pages/shopping%20cart/shoppingCart.dart';
import 'package:veggy/ui/widgets/custom_inputs.dart';
import 'package:veggy/ui/widgets/outline_custom_buttom.dart';

class FormPreOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 0),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 370),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Email
                  BlocBuilder<FormCubit, FormCubitState>(
                    buildWhen: (previous, current) =>
                        previous.userNameComplete != current.userNameComplete,
                    builder: (context, state) {
                      return TextFormField(
                        onChanged: (value) =>
                            context.read<FormCubit>().userNameChanged(value),
                        style: TextStyle(color: Colors.black),
                        decoration: CustomInputs.loginInputDecoration(
                            errorText: state.userNameComplete.invalid
                                ? 'Solo se pueden ingresar letras'
                                : null,
                            hint: 'Ingrese su nombre completo',
                            label: 'Nombre completo',
                            icon: Icons.person_outline),
                      );
                    },
                  ),

                  SizedBox(height: 20),
                  //cedula
                  BlocBuilder<FormCubit, FormCubitState>(
                    buildWhen: (previous, current) => previous.id != current.id,
                    builder: (context, state) {
                      return TextFormField(
                          onChanged: (value) =>
                              context.read<FormCubit>().idChanged(value),
                          style: TextStyle(color: Colors.black),
                          decoration: CustomInputs.loginInputDecoration(
                              errorText: state.id.invalid
                                  ? 'Solo se pueden ingresar numeros'
                                  : null,
                              hint: 'Ingrese su numero de cedula',
                              label: 'Cedula',
                              icon: Icons.contact_mail_rounded));
                    },
                  ),
                  SizedBox(height: 20),
                  // Password
                  BlocBuilder<FormCubit, FormCubitState>(
                    buildWhen: (previous, current) =>
                        previous.email != current.email,
                    builder: (context, state) {
                      return TextFormField(
                        style: TextStyle(color: Colors.black),
                        onChanged: (value) =>
                            context.read<FormCubit>().emailChanged(value),
                        decoration: CustomInputs.loginInputDecoration(
                            errorText: state.email.invalid
                                ? 'Ingrese un email válido'
                                : null,
                            hint: 'Ingrese su email',
                            label: 'Email',
                            icon: Icons.email_outlined),
                      );
                    },
                  ),

                  SizedBox(height: 20),
                  BlocBuilder<FormCubit, FormCubitState>(
                    builder: (context, state) {
                      return TextFormField(
                        onChanged: (value) =>
                            context.read<FormCubit>().addresChanged(value),
                        style: TextStyle(color: Colors.black),
                        decoration: CustomInputs.loginInputDecoration(
                            errorText: state.addres.invalid
                                ? 'Ingrese una dirección válida'
                                : null,
                            hint: 'Ingrese su dirección de domicilio ',
                            label: 'Dirección',
                            icon: Icons.location_city_outlined),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  BlocBuilder<FormCubit, FormCubitState>(
                    builder: (context, state) {
                      return TextFormField(
                        onChanged: (value) =>
                            context.read<FormCubit>().phoneChanged(value),
                        style: TextStyle(color: Colors.black),
                        decoration: CustomInputs.loginInputDecoration(
                            errorText: state.phone.invalid
                                ? 'Ingrese un número de teléfono válido'
                                : null,
                            hint: 'Ingrese su numero telefónico',
                            label: 'Teléfono',
                            icon: Icons.phone_outlined),
                      );
                    },
                  ),
                  SizedBox(height: 24),
                  BlocBuilder<FormCubit, FormCubitState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status,
                    builder: (context, state) {
                      return CustomOutlinedButton(
                        onPressed: state.status == FormzStatus.valid
                            ? () {
                                final list = context
                                    .read<ShoppingcartCubit>()
                                    .state
                                    .listProducts;
                                context.read<FormCubit>().sendPreOrder(list);
                                
                              }
                            : null,
                        text: 'Enviar orden',
                      );
                    },
                  ),
                  SizedBox(height: 24),
                ],
              )),
        ));
  }
}

