import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/utils/colors.dart';
import 'package:flutter_application_1/core/utils/fonts.dart';
import 'package:flutter_application_1/features/recomended_products/widgets/product_card.dart';
import 'package:flutter_application_1/core/utils/string.dart';

// TODO: Backend Team - Fetch recommended products dynamically.
final List<Map<String, String>> sampleProducts = [
  {
    "imageUrl": Path.spiro,
    "title": "V Super Soda Diet Cola Can",
  },
  {
    "imageUrl": Path.spiro,
    "title": "X Energy Drink Zero Sugar",
  },
  {
    "imageUrl": Path.chips,
    "title": "Local tomato chips ",
  },
];



class RecommendedProductsPage extends StatelessWidget {
  const RecommendedProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      backgroundColor: MyColors.whiteColor,
                       /////app bar
      appBar: AppBar(
        backgroundColor: MyColors.whiteColor,
        title: Text("Recommended Similar Products"
        
      ,  style: TextStyle(fontFamily: MyFonts.montserratFont
      ,  color: MyColors.fontColor,fontSize: 15,
      
      ),),

        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_sharp,color:MyColors.arrowColor,),
          onPressed: () => Navigator.pushReplacementNamed(context, Routes.home),
        ),
      ),


                             /////list view 
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: sampleProducts.length,
        itemBuilder: (context, index) {
          return 
          
          ////////////////////////
          
          ProductCard(
            imageUrl: sampleProducts[index]["imageUrl"]!,
            title: sampleProducts[index]["title"]!,
          );
        },
      ),
    );
  }
}
