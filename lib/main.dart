import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_test/core/constants/app_colors.dart';
import 'package:local_test/core/di/provider_scope.dart';
import 'package:local_test/data/repositories/local_repository.dart';
import 'package:local_test/design/screens/auth/auth_screen.dart';
import 'package:local_test/design/screens/auth/bloc/auth_bloc.dart';
import 'package:local_test/design/screens/paper/bloc/paper_bloc.dart';
import 'package:local_test/design/screens/paper/papers_screen.dart';
import 'package:local_test/design/widgets/loading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalRepository.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: AppColors.violetPrimary,
        ),
        darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
          scaffoldBackgroundColor: AppColors.violetPrimary,
        ),
        home: const MyHomePage(),
        builder: (context, child) {
          return Overlay(initialEntries: [
            OverlayEntry(builder: (context) {
              FToast().init(context);
              return child ?? SizedBox.fromSize();
            }),
          ]);
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (p, c) => p != c && c is AuthSuccessState,
      listener: (context, state) {
        context.read<PaperBloc>().add(PaperInitEvent());
      },
      builder: (context, state) {
        if (state is AuthNotState) return const AuthScreen();

        if (state is AuthSuccessState) return const PapersScreen();

        return const Scaffold(body: Loading());
      },
    );
  }
}
