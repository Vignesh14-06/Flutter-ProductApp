import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/product_provider.dart';
import 'repositories/product_repository.dart';
import 'screens/product_list_screen.dart';


void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(ProductData())..fetchProducts(),
      child:MaterialApp(
        title:'Product Listing App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme:ColorScheme.fromSeed(seedColor: Color(0xFF2962D6)).copyWith(primary:Color(0xFF2962D6)),
          scaffoldBackgroundColor: Color(0xFFF5F7FB),
          appBarTheme: AppBarTheme(
            backgroundColor: Color(0xFF2962D6),
            foregroundColor: Colors.white,
            elevation: 0,
            scrolledUnderElevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
        home:ProductListScreen()
      )
    );
  }
}