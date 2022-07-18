import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class PersonInfo {
  String? email = '';
}

class _LoginPageState extends State<LoginPage> {
  PersonInfo info = PersonInfo();
  late FocusNode _email;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _handleSubmitted() {
    final form = _formKey.currentState;
    form?.save();
    debugPrint("a");
  }

  @override
  void initState() {
    super.initState();
    _email = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(height: 25);
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("登录ss"),
        ),
        body: Column(
          children: [
            TextFormField(
              focusNode: _email,
              decoration: const InputDecoration(
                filled: true,
                icon: Icon(Icons.email),
                labelText: "邮箱",
              ),
              onSaved: (value) {
                info.email = value;
              },
            ),
            sizedBoxSpace,
            Center(
              child: ElevatedButton(
                onPressed: _handleSubmitted,
                child: const Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
