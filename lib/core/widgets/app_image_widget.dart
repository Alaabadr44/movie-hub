import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppNetWorkImage extends StatelessWidget {
  const AppNetWorkImage({
    required this.url,
    this.height = 100,
    this.width = 100,
    this.fit = BoxFit.fill,
    Key? key,
    this.borderRadius = BorderRadius.zero,
    this.alignment = Alignment.center,
  }) : super(key: key);
  final String url;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final Alignment alignment;

  final String load1 = 'assets/images/Spinner-1s-200px.gif';
  final String load3 = 'assets/images/load2.gif';

  @override
  Widget build(BuildContext context) {
    // Print.info('path::::::::::: $path');
    try {
      // return ClipRRect(
      //   borderRadius: borderRadius,
      //   child: FadeInImage(
      //     height: height,
      //     width: width,
      //     // for loading
      //     placeholderFit: BoxFit.contain,
      //     placeholder: AssetImage(load3),
      //     image: NetworkImage(url, scale: 0.5),
      //     fit: fit,
      //     imageErrorBuilder: (context, error, st) {
      //       return Container(
      //         alignment: Alignment.center,
      //         height: height,
      //         width: width,
      //         // for error
      //         decoration: const BoxDecoration(
      //           image: DecorationImage(
      //             image: AssetImage("assets/icons/erroeLoad.jpeg"),
      //             fit: BoxFit.contain,
      //           ),
      //         ),
      //       );
      //     },
      //   ),
      // );

      return ClipRRect(
        borderRadius: borderRadius,
        child: Hero(
          tag: url,
          child: CachedNetworkImage(
            height: height,
            width: width,
            fit: fit,
            
            placeholderFadeInDuration: const Duration(milliseconds: 300),
            useOldImageOnUrlChange: true,
            alignment: alignment,
            imageUrl: url,
            placeholder: (context, url) => Image.asset(
              load3,
              height: height,
              fit: fit,
              width: width,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fadeInDuration:
                const Duration(milliseconds: 500), // Set the fade-in duration
            fadeInCurve: Curves.easeIn, // Set the fade-in curve
          ),
        ),
      );
    } catch (e) {
      return Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        // for error
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/icons/erroeLoad.jpeg"),
            fit: BoxFit.contain,
          ),
        ),
      );
    }
  }
}
