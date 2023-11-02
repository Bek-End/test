import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_test/design/screens/auth/bloc/auth_bloc.dart';
import 'package:local_test/design/widgets/button.dart';
import 'package:local_test/design/widgets/text_input.dart';
import 'package:rxdart/subjects.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _activeBtn = BehaviorSubject<bool>.seeded(false);
  late final _usernameCtrl = TextEditingController()..addListener(_listen);
  late final _passwordCtrl = TextEditingController()..addListener(_listen);

  void _listen() {
    _activeBtn
        .add(_usernameCtrl.text.isNotEmpty && _passwordCtrl.text.isNotEmpty);
  }

  void _auth() {
    context.read<AuthBloc>().add(AuthRequestEvent(
          username: _usernameCtrl.text,
          password: _passwordCtrl.text,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 100.0),
                  TextInput(
                    hintText: 'username',
                    controller: _usernameCtrl,
                  ),
                  const SizedBox(height: 16.0),
                  TextInput(
                    obscureText: true,
                    hintText: 'passord',
                    controller: _passwordCtrl,
                  ),
                ],
              ),
              StreamBuilder<bool>(
                stream: _activeBtn.stream,
                builder: (context, snapshot) {
                  return Button.text(
                    text: 'Auth',
                    disabled: !(snapshot.data ?? false),
                    onTap: _auth,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
