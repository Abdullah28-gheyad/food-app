import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/layout/layoutscreen/cubit/cubit.dart';
import 'package:foodapp/layout/layoutscreen/cubit/states.dart';
import 'package:foodapp/modules/welcomescreen/welcomescreen.dart';
import 'package:foodapp/shared/blocobserver.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized() ;
  await Firebase.initializeApp() ;
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  String pizza = 'pizza';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>FoodLayoutCubit()..getProducts(),
      child: BlocConsumer<FoodLayoutCubit,FoodLayoutStates>(
        listener: (context,state){},
        builder: (context,state){
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                appBarTheme: AppBarTheme(
                    elevation: 0.0 ,
                    color: Colors.grey[900] ,
                    backwardsCompatibility: false,
                    foregroundColor: Colors.grey[900] ,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      systemNavigationBarDividerColor: Colors.grey[900] ,
                      systemNavigationBarColor: Colors.grey[900] ,
                      statusBarColor: Colors.grey[900] ,
                    ) ,
                    iconTheme: IconThemeData(
                        color: Colors.white
                    ) ,
                    titleTextStyle: TextStyle(
                      color: Colors.black ,

                    )
                )
            ),
            home: WelcomeScreen(),
          ) ;
        },
      ),
    );
  }
}
