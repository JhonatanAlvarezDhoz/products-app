import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validate_form/UI/input_decoration.dart';
import 'package:validate_form/providers/login_form_provider.dart';
import 'package:validate_form/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBcakground(
          child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 200),
            CardContainer(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text('register',
                      style: Theme.of(context).textTheme.headline5),
                  const SizedBox(height: 30),
                  ChangeNotifierProvider(
                    create: (_) => LoginFormProvider(),
                    child: const _LoginForm(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              'Crear una nueva cuenta',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      )),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    // ignore: avoid_unnecessary_containers
    return Container(
        child: Form(
            key: loginForm.formKey,
            //? Mantener la referencia aqui
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  maxLines: 1,
                  decoration: InputDecorations.authInputDecoration(
                    hintText: 'ex: test@test.com',
                    labelText: 'e-mail',
                    labelTextColor: Colors.green,
                    prefixIconColor: Colors.deepPurple,
                    prefixIcon: Icons.mail,
                  ),
                  onChanged: (value) => loginForm.email,
                  validator: (value) {
                    String pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regExp = RegExp(pattern);

                    return regExp.hasMatch(value ?? '')
                        ? null
                        : "El valor ingresado no es un correo";
                  },
                ),
                const SizedBox(height: 30),
                TextFormField(
                  autocorrect: false,
                  obscureText: true,
                  maxLines: 1,
                  decoration: InputDecorations.authInputDecoration(
                    hintText: 'Insert password',
                    labelText: 'Password',
                    labelTextColor: Colors.green,
                    prefixIconColor: Colors.deepPurple,
                    prefixIcon: Icons.lock,
                  ),
                  onChanged: (value) => loginForm.password,
                  validator: (value) {
                    return (value != null && value.length >= 6)
                        ? null
                        : "La contraseña debe ser mayor a 6 caracteres";
                  },
                ),
                const SizedBox(height: 50),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    disabledColor: Colors.green,
                    elevation: 1,
                    color: Colors.deepPurple,
                    onPressed: loginForm.isLoading
                        ? null
                        : () async {
                            FocusScope.of(context).unfocus();
                            if (!loginForm.isValidForm()) return;

                            loginForm.isLoading = true;

                            await Future.delayed(const Duration(seconds: 2));

                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacementNamed(context, 'home');
                          },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 80, vertical: 15),
                      child: Text(
                        loginForm.isLoading ? 'Loading...' : 'Login',
                        style: const TextStyle(
                            color: Colors.white,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w700),
                      ),
                    ))
              ],
            )));
  }
}
