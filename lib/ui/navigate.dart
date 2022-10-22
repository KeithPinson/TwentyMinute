import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class Navigate extends StatefulWidget {
  const Navigate({Key? key}) : super(key: key);

  @override
  NavigateState createState() => NavigateState();
}

class NavigateState extends State<Navigate> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  var pages = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (pages.length > 1) {
      return Row(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
            child: Icon(Icons.arrow_back_ios_new_rounded),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 3, // pages.length,
                  effect: const WormEffect (
                    dotHeight: 16,
                    dotWidth: 16,
                    type: WormType.thin,
                  )
                )
              )
            )
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
            child: Icon(Icons.arrow_forward_ios_rounded),
          ),
        ],
      );
    } else {
      return const Padding(
        padding: EdgeInsets.all(10),
        child: Text(' '),
      );
    }
  }
}


// bool hoverTask = false;
// bool hoverTally = false;
// bool hoverRight = false;
// bool hoverLeft = false;
//
//
//
// SvgPicture setIcon(String side) {
//   var is_left = (side.toLowerCase() != 'right');
//
//   String hoverIcon = (hoverLeft && is_left) ? 'assets/icons/screen-left-lt.svg' : 'assets/icons/screen-left-lt.svg';
//   bool active = (hoverLeft || hoverTally);
//
//   // (hoverLeft | hoverTally ? 'assets/icons/screen-left-lt.svg' : 'assets/icons/screen-left-dk.svg')
//
//   return
//     SvgPicture.asset(
//       hoverIcon,
//       semanticsLabel: 'Screen Left',
//       color: (hoverLeft ? Colors.grey[5 * 100] : Colors.grey[2*100]),
//       height: 48,
//       width: 46,
//     );
// }
//
//
//
// Row(
// children: <Widget>[
//
// // Screen Left Button
// // ------------------
// Padding(
// padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
// // child: Icon(Icons.arrow_back_ios_new_rounded),
// child: IconButton(
// onPressed: () {
// setState(() { hoverLeft = false; });
// },
// // onHover: (hovering) => { hoverLeft = hovering},
// // hoverColor: ThemeData.light.,
// icon: setIcon('left', /*(hoverLeft | hoverTally)*/true),
// iconSize: 32,
// // icon: const ImageIcon(
// //   AssetImage('assets/images/screen-left-lt.png'),
// //   size: 48,
// // ),
// ),
// ),
//
//
// // Screen Right Button
// // -------------------
// Padding(
// padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
// // child: Icon(Icons.arrow_forward_ios_rounded),
// child: IconButton(
// onPressed: () {
// setState(() { hoverRight = false; });
// },
// // hoverColor: Colors.black26,
// icon: SvgPicture.asset(
// 'assets/icons/screen-right-lt.svg',
// semanticsLabel: 'Screen Left',
// height: 48,
// width: 46,
// ),
// iconSize: 32,
// ),
// ),
// ],
// ),
