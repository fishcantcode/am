import 'package:aaaaa/utils/colors.dart';
import 'package:aaaaa/utils/screen_adapter.dart';
import 'package:flutter/material.dart';

class ShopCard extends StatelessWidget {
  const ShopCard({super.key, required this.route});

  final String route;

  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      height: 200,
      child: GestureDetector(
        child: Card(
          elevation: 10,
          color: UtilColors.pColor,
          child: Row(
            children: [
              SizedBox(
                  width: ScreenAdapter.screenWidth! * 0.33,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: SizedBox.fromSize(
                        size: Size.fromRadius(70),
                        child: Image.asset('assets/img/help.jpg',
                            fit: BoxFit.cover),
                      ),
                    ),
                  )),
              Flexible(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'someone nmae',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'someone nmae',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: UtilColors.tColor,
                            size: 14,
                          ),
                          Text('km'),
                        ],
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.star,
                            color: Colors.amberAccent,
                            size: 14,
                          ),
                          Text('0.0'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
