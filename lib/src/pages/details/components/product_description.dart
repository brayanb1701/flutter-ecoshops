import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/services/products_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_ecoshops/models/product.dart';

import 'package:flutter_ecoshops/constants.dart';
import 'package:flutter_ecoshops/size_config.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ecoshops/services/services.dart';
import 'package:flutter_ecoshops/models/entrepreneurship.dart';
import 'package:flutter_ecoshops/src/pages/details/details_screen.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key? key,
    required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final Product product;
  final GestureTapCallback? pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    final entServices = Provider.of<EntrepreneurshipService>(context);
    final Future<Entrepreneurship> profile =
        entServices.getProfile(product.idEntrepreneurship);
    return FutureBuilder(
        future: profile,
        builder:
            (BuildContext context, AsyncSnapshot<Entrepreneurship> snapshot) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Text(
                    product.nameProd,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                    vertical: 5,
                  ),
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, 'entrepreneurships',
                        arguments: {"id_ent": product.idEntrepreneurship}),
                    child: Row(
                      children: [
                        Text(
                          snapshot.data!.entrepreneurshipName,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: kPrimaryColor),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: kPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.all(getProportionateScreenWidth(15)),
                    width: getProportionateScreenWidth(64),
                    decoration: BoxDecoration(
                      color: product.isFavourite
                          ? Color(0xFFFFE6E6)
                          : Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: SvgPicture.asset(
                      "assets/icons/Heart Icon_2.svg",
                      color: product.isFavourite
                          ? Color(0xFFFF4848)
                          : Color(0xFFDBDEE4),
                      height: getProportionateScreenWidth(16),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(20),
                    right: getProportionateScreenWidth(64),
                  ),
                  child: Text(
                    product.descp,
                    maxLines: 5,
                  ),
                ),
              ],
            );
          } else {
            return Text("No data found.");
          }
        });
  }
}
