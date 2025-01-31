import 'package:aaaaa/utils/colors.dart';
import 'package:aaaaa/utils/screen_adapter.dart';
import 'package:aaaaa/views/detail_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShopDetail extends StatefulWidget {
  const ShopDetail({super.key});

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
          About(),
          Body(),
          Portfolio(),
          const Spacer(),
          Padding(
              padding: const EdgeInsets.all(15),
              child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed('booking');
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

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/img/help.jpg'),
            backgroundColor: UtilColors.background,
          ),
          SizedBox(height: 25),
          const Text(
            'someoena name',
            style: TextStyle(
              color: UtilColors.tColor,
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 5),
          TextButton.icon(
            onPressed: () { },
            icon: const FaIcon(Icons.map,
            color: UtilColors.tColor,),
            label: const Text(
              'your address',
              style: TextStyle(
                color: UtilColors.tColor,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'About',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            'yeah yeahyeahyeahyeahyeahyeahyeahyeahyeahyeah',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          )
        ],
      ),
    );
  }
}

class Portfolio extends StatelessWidget {
  const Portfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Portfolio',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

