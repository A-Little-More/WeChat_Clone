import 'package:flutter/material.dart';
import 'package:wechat_clone_01/home/home_screen.dart';
import 'others/colors/colors.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'WeChat_Clone',
      theme: ThemeData.light().copyWith(
        primaryColor: themeColor,
        cardColor: themeColor
      ),
      home: HomePageWidget(),
    )
  );
}

