import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splash_app/screens/products_screen.dart';

import 'manager/cart_cubit/cart_cubit.dart';
import 'manager/products_cubit/products_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(
          create: (context) => ProductsCubit()..getProducts(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white)
              .copyWith(brightness: Brightness.dark),
          useMaterial3: true,
        ),
        home: const ProductsScreen(),
      ),
    );
  }
}
