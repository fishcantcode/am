import 'package:aaaaa/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailBar extends StatefulWidget implements PreferredSizeWidget {
  DetailBar({Key? key, this.title, this.route, this.icon, this.actions})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  final String? title;
  final String? route;
  final FaIcon? icon;
  final List<Widget>? actions;

  @override
  State<DetailBar> createState() => _DetailBarState();
}

class _DetailBarState extends State<DetailBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: UtilColors.background,
      elevation: 0,
      title: Text(
        widget.title!,
        style: const TextStyle(
          fontSize: 24,
          color: UtilColors.tColor,
        ),
      ),
      leading: widget.icon != null
          ? Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: UtilColors.pColor,
              ),
              child: IconButton(
                onPressed: () {
                  if (widget.route != null) {
                    Navigator.of(context).pushNamed(widget.route!);
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                icon: widget.icon!,
                iconSize: 16,
                color: UtilColors.mColor,
              ),
            )
          : null,
      actions: widget.actions ?? null,
    );
  }
}
