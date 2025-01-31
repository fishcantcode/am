import 'package:aaaaa/utils/colors.dart';
import 'package:aaaaa/utils/screen_adapter.dart';
import 'package:aaaaa/views/detail_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../model/shop_model.dart';

class ShopDetail extends StatefulWidget {
  final Shop shop;


  const ShopDetail({super.key, required this.shop});

  @override
  State<ShopDetail> createState() => _ShopDetailState();
}

class _ShopDetailState extends State<ShopDetail> {
  late bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailBar(
        title: 'Details',
        icon: const FaIcon(Icons.arrow_back),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isFavourite = !isFavourite;
                });
              },
              icon: FaIcon(
                isFavourite ? Icons.favorite : Icons.favorite_border,
                color: UtilColors.pColor,
              ))
        ],
      ),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
              CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(widget.shop.imageUrl!),
              backgroundColor: UtilColors.background,
            ),
            SizedBox(height: 25),
            Text( widget.shop.name,
            style: const TextStyle(
            color: UtilColors.tColor,
            fontSize: 26,
            fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 5),
                Text( widget.shop.address,
                  style: const TextStyle(
                    color: UtilColors.tColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
          TextButton.icon(
            onPressed: () {
              //openMap();
            },
            icon: const FaIcon(Icons.map,
              color: UtilColors.tColor,),
            label: const Text(
              'Click here to see map',
              style: TextStyle(
                color: UtilColors.tColor,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: UtilColors.pColor,
            ),
          ),
          SizedBox(height: 25),
        ],
          ),
      ),
        Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'About',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
              SizedBox(height: 10),
              Text(
                widget.shop.description,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              )
            ],
          ),
        ),
          const Spacer(),
          Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed('booking',
                        arguments: widget.shop);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: UtilColors.pColor,
                        foregroundColor: UtilColors.tColor,
                      ),
                      child: Text(
                        'Book',
                        style: const TextStyle(
                          fontFamily: 'Mitr',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      )))
          )
        ],
      )),
    );
  }
}


