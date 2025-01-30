import 'package:aaaaa/views/detail_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShopDetail extends StatefulWidget {
  const ShopDetail({super.key});

  @override
  State<ShopDetail> createState() => _ShopDetailState();
}

class _ShopDetailState extends State<ShopDetail> {
  late bool isFavourite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailBar(
        title: 'Details',
        icon: const FaIcon(Icons.arrow_back),
      ),
    );
  }
}
