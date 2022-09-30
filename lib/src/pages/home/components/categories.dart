import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/services/categories_services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_ecoshops/size_config.dart';
import 'package:provider/provider.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoriesServices = Provider.of<CategoriesService>(context);
    categoriesServices.loadCategories();
    final List<String> names = categoriesServices.categories.keys.toList();
    final List<String> icons = categoriesServices.categories.values.toList();

    return Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
              names.length,
              (index) => CategoryCard(
                  icon: "assets/icons/" + icons[index] + ".svg",
                  text: names[index],
                  press: () {})),
        ));
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String? icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Color(0xFF9DBE76),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(icon!),
            ),
            SizedBox(height: 5),
            Text(text!, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
