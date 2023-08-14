import 'package:flutter/material.dart';

import '../../../../core/widgets/app_image_widget.dart';
import '../../../../core/widgets/paginations_widgets.dart';
import '../../domain/entities/movie_entity.dart';
import '../moive-details/screen/movie_details_screen.dart';

// class MovieItemView extends PaginationViewItem<MovieEntity> {
//   const MovieItemView({
//     super.key,
//     required super.data,
//   });
// //
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () =>,
//       child: Container(
//         alignment: Alignment.bottomCenter,
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey.shade300),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             Center(
//               child: AppNetWorkImage(
//                 borderRadius:
//                     const BorderRadius.vertical(top: Radius.circular(10)),
//                 url: data.movieImage ?? "",
//                 height: 350,
//                 fit: BoxFit.fitWidth,
//                 alignment: Alignment.topRight,
//                 width: double.maxFinite,
//               ),
//             ),
//             Container(
//               child: Row(
//                 children: [
//                   const Icon(Icons.star, color: Colors.yellow, size: 18),
//                   const SizedBox(width: 4),
//                   Text(
//                     data.voteAverage.toString(),
//                     style: const TextStyle(
//                       fontSize: 17,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.white,
//                       fontFamily: 'Muli',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Align(
//               alignment: Alignment.center,
//               child: Text(
//                 data.title!,
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.white,
//                   fontFamily: 'Muli',
//                 ),
//                 textScaleFactor: 2,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class MovieItemView extends PaginationViewItem<MovieEntity> {
  final GlobalKey backgroundImageKey = GlobalKey();

  MovieItemView({
    Key? key,
    required super.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(MovieDetailsView.routeName, arguments: data),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              children: [
                Flow(
                  delegate: _ParallaxFlowDelegate(
                    scrollable: Scrollable.of(context),
                    listItemContext: context,
                    backgroundImageKey: backgroundImageKey,
                  ),
                  children: [
                    AppNetWorkImage(
                      key: backgroundImageKey,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(10)),
                      url: data.movieImage ?? "",
                      height: 650,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topRight,
                      width: double.maxFinite,
                    )
                  ],
                ),
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.6, 0.95],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  bottom: 20,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width / 10 * 7,
                        child: Text(
                          data.title!,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.yellow, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            data.voteAverage.toString(),
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontFamily: 'Muli',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ParallaxFlowDelegate extends FlowDelegate {
  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  _ParallaxFlowDelegate({
    required this.scrollable,
    required this.listItemContext,
    required this.backgroundImageKey,
  }) : super(repaint: scrollable.position);

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(width: constraints.maxWidth);
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // Calculate the position of this list item within the viewport.
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
      listItemBox.size.centerLeft(Offset.zero),
      ancestor: scrollableBox,
    );

    // Determine the percent position of this list item within the
    // scrollable area.
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction =
        (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    // Calculate the vertical alignment of the background
    // based on the scroll percent.
    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    // Convert the background alignment into a pixel offset for
    // painting purposes.
    final backgroundSize =
        (backgroundImageKey.currentContext!.findRenderObject() as RenderBox)
            .size;
    final listItemSize = context.size;
    final childRect = verticalAlignment.inscribe(
      backgroundSize,
      Offset.zero & listItemSize,
    );

    // Paint the background.
    context.paintChild(
      0,
      transform: Transform.translate(
        offset: Offset(
          0.0,
          childRect.top,
        ),
      ).transform,
    );
  }

  @override
  bool shouldRepaint(_ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        listItemContext != oldDelegate.listItemContext ||
        backgroundImageKey != oldDelegate.backgroundImageKey;
  }
}
