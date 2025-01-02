import 'package:flutter/material.dart';
import 'package:play_lab/core/utils/dimensions.dart';
import 'package:play_lab/core/utils/my_color.dart';
import 'package:play_lab/core/utils/styles.dart';
import 'package:tapped/tapped.dart';

class VideoButtonColumn extends StatelessWidget {
  final double? bottomPadding;
  final bool isFavorite;
  final Function? onFavorite;

  final bool isLike;
  final bool isDisLike;
  final Function? onLike;
  final Function? onDislike;

  const VideoButtonColumn({
    super.key,
    this.bottomPadding,
    this.onFavorite,
    this.onLike,
    this.isFavorite = false,
    this.isDisLike = false,
    this.isLike = false,
    this.onDislike,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      margin: EdgeInsets.only(
        bottom: bottomPadding ?? 50,
        right: 12,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          MyIconButton(icon: IconToText(isFavorite ? Icons.favorite : Icons.favorite_border, size: 40, color: isFavorite ? MyColor.red : MyColor.colorWhite), text: 'Favorite', onTap: onFavorite),
          const SizedBox(height: Dimensions.space20),
          MyIconButton(icon: IconToText(isLike ? Icons.thumb_up : Icons.thumb_up_outlined, size: 40, color: isLike ? Colors.blue : MyColor.colorWhite), text: 'Like', onTap: onLike),
          MyIconButton(icon: IconToText(isDisLike ? Icons.thumb_down : Icons.thumb_down_outlined, size: 40, color: MyColor.colorWhite), text: 'Dislike', onTap: onDislike),
          const SizedBox(height: Dimensions.space20),
          Container(
            width: 56,
            height: 56,
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(56 / 2.0)),
          )
        ],
      ),
    );
  }
}

class IconToText extends StatelessWidget {
  final IconData? icon;
  final TextStyle? style;
  final double? size;
  final Color? color;

  const IconToText(
    this.icon, {
    super.key,
    this.style,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      String.fromCharCode(icon!.codePoint),
      style: style ??
          TextStyle(
            fontFamily: 'MaterialIcons',
            fontSize: size ?? 30,
            inherit: true,
            color: color ?? MyColor.colorWhite,
          ),
    );
  }
}

class MyIconButton extends StatelessWidget {
  final Widget? icon;
  final String? text;
  final Function? onTap;

  const MyIconButton({
    super.key,
    this.icon,
    this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var shadowStyle = TextStyle(
      shadows: [
        Shadow(
          color: Colors.black.withOpacity(0.15),
          offset: const Offset(0, 1),
          blurRadius: 1,
        ),
      ],
    );
    Widget body = Column(
      children: <Widget>[
        Tapped(
          onTap: onTap,
          child: icon ?? Container(),
        ),
        Container(height: 2),
        Text(text ?? '??', style: regularSmall),
      ],
    );
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: DefaultTextStyle(
        style: shadowStyle,
        child: body,
      ),
    );
  }
}
