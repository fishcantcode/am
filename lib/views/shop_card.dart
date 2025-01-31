import 'package:aaaaa/utils/colors.dart';
import 'package:aaaaa/utils/screen_adapter.dart';
import 'package:flutter/material.dart';

class ShopCard extends StatelessWidget {
  const ShopCard({super.key , required this.name, required this.address,required this.imageUrl, required this.phone});

  final String name;
  final String imageUrl;
  final String address;
  final num  phone;

  Widget build(BuildContext context) {
    bool imageUrlExist(){
        return imageUrl != null && imageUrl.isNotEmpty;
    }
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
                        child: imageUrlExist()? Image.network(imageUrl, fit: BoxFit.cover)
                            : Image.asset('assets/img/help.jpg', fit: BoxFit.cover),
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
                        name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        address,
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
                            Icons.phone,
                            color: UtilColors.tColor,
                            size: 14,
                          ),
                          Text(phone.toString()),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
