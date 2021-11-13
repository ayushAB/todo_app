import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/auth_cubit/auth_cubit.dart';
import 'package:todo_app/data/network/auth_service.dart';
import 'package:todo_app/data/repository/auth_repository.dart';
import 'package:todo_app/presentation/screens/authentication/Login.dart';

class AppRouter {
  late AuthRepository authRepository;
  late AuthCubit authCubit;

  AppRouter() {
    authRepository = AuthRepository(loginService: LoginService());
    authCubit = AuthCubit(authRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: authCubit,
                  child: Login(),
                ));
      case "/home":
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider<AuthCubit>(
                    create: (BuildContext context) => authCubit,
                  ),
                ], child: Login()));
      default:
        return null;
    }
  }
}
