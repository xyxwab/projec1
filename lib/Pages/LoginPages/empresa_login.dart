import 'package:flutter/material.dart';
import 'package:projec1/Pages/recuperar_page.dart';
import 'package:projec1/perfis/empresa_perfil.dart';
import 'package:projec1/pages/loginpages/forms/empresa_form.dart';
import 'package:projec1/providers/themeprovider.dart';
import 'package:provider/provider.dart';

final _formKey = GlobalKey<FormState>();

class EmpresaLoginInfo extends StatefulWidget {
  const EmpresaLoginInfo({super.key});

  @override
  State<EmpresaLoginInfo> createState() => _EmpresaLoginInfoState();
}

class _EmpresaLoginInfoState extends State<EmpresaLoginInfo> {
  String usuarioEmpresa = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('LOGIN PARA EMPRESAS'),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
            icon: Consumer<ThemeProvider>(
              builder: (context, themeProvider, _) => themeProvider.isDarkMode
                  ? const Icon(Icons.wb_sunny)
                  : const Icon(Icons.nightlight_round),
            ),
          ),
          Switch(
            value: Provider.of<ThemeProvider>(context).isDarkMode,
            onChanged: (value) {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Empresa não é cadastrado? Clique em Cadastrar',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                key: const Key('usuarioEmpresa'),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Usuario / E-mail / CNPJ',
                  prefixIcon: Icon(Icons.business),
                ),
                keyboardType: TextInputType.text,
                onChanged: (ctx) => usuarioEmpresa = ctx,
                validator: (usuarioEmpresa) => usuarioEmpresa!.length < 4
                    ? 'Usuário deve possuir pelo menos 3 caracteres*'
                    : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              TextFormField(
                key: const Key('senhaEmpresa'),
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Senha',
                  prefixIcon: Icon(
                    Icons.key,
                  ),
                  suffixIcon: Icon(
                    Icons.remove_red_eye,
                  ),
                ),
                keyboardType: TextInputType.text,
                validator: (value) => value!.isEmpty ? 'Senha inválida' : null,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RecuperarSenha()));
                },
                child: const Text(
                  'Esqueceu sua senha?',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EmpresaForm(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Cadastrar',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EmpresaPerfil(usuarioEmpresa: usuarioEmpresa),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
