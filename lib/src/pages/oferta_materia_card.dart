import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/constants.dart';

class OfertaMateriaCard extends StatelessWidget {
  final Map info;
  //final void Function() press;
  const OfertaMateriaCard({
    Key? key,
    required this.info,
    //required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Color(0xFF597C2B),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    info['address'],
                    style: TextStyle(fontSize: 11),
                  )
                ],
              ),
              Divider(
                thickness: 2,
              ),
              Column(children: [
                Text(
                  "Descripción",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  info['description'].padLeft(6, ' '),
                  style: TextStyle(color: Colors.black),
                ),
              ]),
              Divider(
                thickness: 2,
              ),
              Row(
                children: [
                  Icon(
                    Icons.email_outlined,
                    color: Color(0xFF597C2B),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    info['email'],
                    style: TextStyle(fontSize: 11),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
