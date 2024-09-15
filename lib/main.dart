import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payuung/bloc/auth/auth_bloc.dart';
import 'package:payuung/swipable_bar.dart';

const primaryColor = Color.fromRGBO(241, 195, 31, 1.0);
void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(GetUser()),
      child: MaterialApp(
        title: 'Payuung Clone',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white, scrolledUnderElevation: 0),
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
          primaryColor: primaryColor,
          hintColor: primaryColor,
          scaffoldBackgroundColor: Colors.white,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.grey, // Warna kursor
            selectionColor: Colors.grey, // Warna seleksi teks
            selectionHandleColor: Colors.blue, // Warna handle seleksi
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: primaryColor),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)))),
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Mengatur border radius
                    ),
                  ),
                  foregroundColor: const WidgetStatePropertyAll(Colors.grey))),
          inputDecorationTheme: InputDecorationTheme(
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(8)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(8)),
              hintStyle:
                  TextStyle(color: Colors.grey.withOpacity(0.5), fontSize: 14),
              isDense: true,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(8)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
              contentPadding: const EdgeInsets.all(10)),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              elevation: const WidgetStatePropertyAll(0),
              backgroundColor: const WidgetStatePropertyAll(primaryColor),
              foregroundColor: const WidgetStatePropertyAll(Colors.white),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
        home: const VerticalSwipeableBottomBar(),
      ),
    );
  }
}
