import 'package:account_flutter/api/user.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("登录"),
      ),
      body: Form(
        key: _formKey,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            TextFormField(
              autofocus: true,
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "用户名",
                hintText: "您的用户名或者邮箱",
                prefixIcon: Icon(Icons.person),
              ),
              validator: (v) {
                return v!.trim().isNotEmpty ? null : "用户名不能为空";
              },
            ),
            TextFormField(
              controller: _pwdController,
              decoration: const InputDecoration(
                  labelText: "密码",
                  hintText: "您的登录密码",
                  prefixIcon: Icon(Icons.lock)),
              obscureText: true,
              validator: (v) {
                return v!.trim().length > 2 ? null : '密码不能少于3位';
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 28),
              child: Row(
                children: <Widget>[
                  Expanded(child: Builder(
                    builder: (ctx) {
                      return ElevatedButton(
                        onPressed: () {
                          if (Form.of(ctx).validate()) {
                            UserApi.login(
                                    _emailController.text, _pwdController.text)
                                .then((success) => {
                                      if (success)
                                        Navigator.pushNamed(context, "/")
                                      else
                                        {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text("登录失败")))
                                        }
                                    });
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text("登录"),
                        ),
                      );
                    },
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
