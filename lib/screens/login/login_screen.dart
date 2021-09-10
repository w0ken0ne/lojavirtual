import 'package:flutter/material.dart';
import 'package:lojavirtual/helpers/validators.dart';
import 'package:lojavirtual/models/user.dart';
import 'package:lojavirtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Entrar"),
        leading: const BackButton(),
        actions: [const Center(child: Text("Criar conta"))],
        centerTitle: true,
      ),
      body: Center(
        child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Consumer<UserManager>(
                builder: (_, userManager, __) {
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    shrinkWrap: true,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Email",
                        ),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        validator: (email) {
                          if (!emailValid(email!)) {
                            return "Email inválido";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Senha",
                        ),
                        controller: passwordController,
                        autocorrect: false,
                        obscureText: true,
                        validator: (password) {
                          if (password!.isEmpty || password.length < 6) {
                            return "Senha inválida!";
                          }
                          return null;
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text("Esqueci minha senha"),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 44,
                        child: RaisedButton(
                          onPressed: () {
                            //only if the user clicks the button it validates
                            if (formKey.currentState!.validate()) {
                              //call firebase signin
                              final user = User(
                                  email: emailController.text,
                                  password: passwordController.text);
                              context.read<UserManager>().signIn(
                                  user: user,
                                  onSuccess: () {
                                    print("Sucesso");
                                    //TODO FECHAR TELA DE LOGIN
                                  },
                                  onFail: (e) {
                                    // scaffoldKey.currentState!.showSnackBar(SnackBar(
                                    //   content: Text("Falha ao entrar: $e"),
                                    //   backgroundColor: Colors.red,
                                    // ));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text("Falha ao entrar: $e"),
                                      backgroundColor: Colors.red,
                                    ));
                                  });
                            }
                          },
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          child: const Text(
                            "Entrar",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            )),
      ),
    );
  }
}
