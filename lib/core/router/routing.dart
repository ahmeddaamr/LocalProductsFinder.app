import 'package:flutter/material.dart';
import 'package:localproductsfinder/core/utils/string.dart';
import 'package:localproductsfinder/features/camera/view/camera_page.dart';
import 'package:localproductsfinder/features/home/view/home_page.dart';
import 'package:localproductsfinder/features/login/view/login.dart';
import 'package:localproductsfinder/features/make_review/makeReview_view.dart';
import 'package:localproductsfinder/features/onBoarding/onBoarding.dart';
import 'package:localproductsfinder/features/recomended_products/view/recommended_products_page.dart';
import 'package:localproductsfinder/features/sign_up/view/signup.dart';
// import 'package:localproductsfinder/features/recomended_products/view/recommended_products_page.dart';
import 'package:localproductsfinder/features/splash/splash.dart';
import 'package:localproductsfinder/features/userProfileOptions_page/userProfile_selection.dart';


class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //  Route generateRoute (RouteSettings settings)
    {
      //final arrgu = settings.arguments;
      //   case Routes.recommendation:
      //   return MaterialPageRoute(builder: (_) => const RecommendedProductsPage());

      //  case Routes.favorit:
      //   return MaterialPageRoute(builder: (_) => const RecommendedProductsPage());

      // case Routes.recommendation:
      //   return MaterialPageRoute(builder: (_) => RecommendedProductsPage());

      switch (settings.name) {
        case Routes.splash:
          return MaterialPageRoute(builder: (_) => const Splash());

        case Routes.home:
          return MaterialPageRoute(builder: (_) => const HomeScreen());

        case Routes.profile:
          return MaterialPageRoute(builder: (_) => const HomeScreen());

        case Routes.camera:
          return MaterialPageRoute(builder: (_) => const CameraPage());

        case Routes.signUp:
          return MaterialPageRoute(builder: (_) => signupPage());

        case Routes.login:
          return MaterialPageRoute(builder: (_) => LoginPage());

        case Routes.editProfile:
          return MaterialPageRoute(builder: (_) => UserProfileSelection());

        // case Routes.review:
        //   return MaterialPageRoute(
        //     builder:
        //         (_) => MakeReviewPage(
        //           // productTitle:
        //           //     'here my spiro ', 
        //           // productImageUrl:
        //           //     Path.spiro, 
        //           // product:product
        //         ),
        //   );

        case Routes.onBording:
          return MaterialPageRoute(builder: (_) => OnboardingScreen());

        default:
          return MaterialPageRoute(
            builder: (_) => const HomeScreen(),

            //Scaffold(
            //body: Center( child: Text('No Route ${settings.name}'),),
          );
      }
    }
  }
}
