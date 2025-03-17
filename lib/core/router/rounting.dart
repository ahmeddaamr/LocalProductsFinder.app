
import 'package:flutter/material.dart';
import 'package:localproductsfinder/core/utils/string.dart';
import 'package:localproductsfinder/features/camera/view/camera_page.dart';
import 'package:localproductsfinder/features/home/view/home_page.dart';
// import 'package:localproductsfinder/features/recomended_products/view/recommended_products_page.dart';
import 'package:localproductsfinder/features/splash/splash.dart';

class AppRouter{

   static Route<dynamic> generateRoute(RouteSettings settings) {
    //  Route generateRoute (RouteSettings settings)
  {
    //final arrgu = settings.arguments;
    
    switch(settings.name){
     
      case Routes.splash:
      return MaterialPageRoute(builder: (_) => const Splash());
     
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      //   case Routes.recommendation:
      //   return MaterialPageRoute(builder: (_) => const RecommendedProductsPage());
        
      //  case Routes.favorit:
      //   return MaterialPageRoute(builder: (_) => const RecommendedProductsPage());


        case Routes.profile:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
        
        case Routes.camera:
        return MaterialPageRoute(builder: (_) => const CameraPage());

      default:
      return MaterialPageRoute(builder: (_) => const HomeScreen()
        //Scaffold(
       //body: Center( child: Text('No Route ${settings.name}'),),
      );
    
    
    }
    


  }




}



}