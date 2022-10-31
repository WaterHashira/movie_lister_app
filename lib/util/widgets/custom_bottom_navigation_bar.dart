import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/home_icon.svg'), label: ''),
        BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/cup_icon.svg'), label: ''),
        BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/film_board_icon.svg'),
            label: ''),
        BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/graph_icon.svg'), label: ''),
      ],
    );
  }
}
