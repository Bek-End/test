import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_test/data/repositories/local_repository.dart';
import 'package:local_test/data/repositories/remote_repository.dart';
import 'package:local_test/data/repositories_impl/local_repository_impl.dart';
import 'package:local_test/data/repositories_impl/remote_repository_impl.dart';
import 'package:local_test/design/screens/auth/bloc/auth_bloc.dart';
import 'package:local_test/design/screens/paper/bloc/paper_bloc.dart';

class ProviderScope extends StatelessWidget {
  const ProviderScope({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LocalRepository>(
          create: (context) => LocalRepositoryImpl(),
        ),
        RepositoryProvider<RemoteRepository>(
          create: (context) => RemoteRepositoryImpl(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              localRepo: context.read(),
              remoteRepo: context.read(),
            )..add(AuthInitEvent()),
          ),
          BlocProvider(
            create: (context) => PaperBloc(
              remoteRepo: context.read(),
            ),
          ),
        ],
        child: child,
      ),
    );
  }
}
