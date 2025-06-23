
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/string.dart';
import 'package:flutter_application_1/features/camera/view/camera_page.dart';
import 'package:flutter_application_1/features/home/view/home_page.dart';
import 'package:flutter_application_1/features/lg_in/view/login.dart';
import 'package:flutter_application_1/features/make_review/makeReview_view.dart';
import 'package:flutter_application_1/features/onBoarding/onBoarding.dart';
import 'package:flutter_application_1/features/recomended_products/view/recommended_products_page.dart';
import 'package:flutter_application_1/features/sign_up/view/sighUp.dart';
import 'package:flutter_application_1/features/splash/splash.dart';
import 'package:flutter_application_1/features/user_profile/userProfile_view.dart';
// import 'package:flutter_application_1/features/lg_in/view/log_in.dart';



class AppRouter{

   static Route<dynamic> generateRoute(RouteSettings settings) {
    //  Route generateRoute (RouteSettings settings)
  {
    //final arrgu = settings.arguments;
    
    switch(settings.name){
     
      case Routes.splash:
      return MaterialPageRoute(builder: (_) => Splash());
     
      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case Routes.signUp:
        return MaterialPageRoute(builder: (_) => signupPage());

      case Routes.login:
        return MaterialPageRoute(builder: (_) => LoginPage());

        case Routes.recommendation:
        return MaterialPageRoute(builder: (_) => RecommendedProductsPage());
        
       case Routes.onBording:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());


        case Routes.profile:
        return MaterialPageRoute(builder: (_) => ProfileView());
        
        case Routes.camera:
        return MaterialPageRoute(builder: (_) => CameraPage());





      case Routes.review:
        return MaterialPageRoute(
          builder: (_) => MakeReviewPage(
            productTitle: 'here my spiro ', // TODO: Replace with actual product title
            productImageUrl: Path.spiro, // TODO: Replace with actual product image URL
          ),
        );

      default:
      return MaterialPageRoute(builder: (_) => HomeScreen()
        //Scaffold(
       //body: Center( child: Text('No Route ${settings.name}'),),
      );
    
    
    }
    


  }




}



}