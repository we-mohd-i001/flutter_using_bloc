import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_using_bloc/logic/cubit/counter_cubit.dart';
import 'package:flutter_using_bloc/logic/cubit/internet_cubit.dart';
import 'package:flutter_using_bloc/presentation/router/app_router.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());

  runApp(CounterApp(connectivity: Connectivity(), appRouter: AppRouter(),));
}

class CounterApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;

  CounterApp({super.key, required this.connectivity, required this.appRouter,});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => InternetCubit(connectivity)),
        BlocProvider(create: (context) => CounterCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
