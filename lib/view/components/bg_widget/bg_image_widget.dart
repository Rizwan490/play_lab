import 'package:play_lab/core/utils/my_images.dart';
import 'package:flutter/material.dart';



class MyBgWidget extends StatelessWidget {
  final String image;
  const MyBgWidget({super.key,this.image=MyImages.onboardingBG});

  @override
  Widget build(BuildContext context) {
    return  ShaderMask(
      shaderCallback: (bounds) =>  LinearGradient(
        colors: [Colors.black.withOpacity(.9), Colors.black.withOpacity(.9)],
        begin: Alignment.bottomCenter,
        end: Alignment.center,
      ).createShader(bounds),
      blendMode: BlendMode.darken,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration:  BoxDecoration(image: DecorationImage(image: AssetImage(image,), fit: BoxFit.cover)
        ),
      )
    );
  }
}

