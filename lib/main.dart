import 'package:flutter/material.dart';
import 'package:wechat_clone_01/home/home_screen.dart';
import 'others/colors/colors.dart' show AppColor;

void main() {
  runApp(
    MaterialApp(
      title: 'WeChat_Clone',
      theme: ThemeData.light().copyWith(
        primaryColor: AppColor.ThemeColor,/*主题颜色*/
        cardColor: AppColor.ThemeColor/*卡片颜色*/
      ),
      home: HomePageWidget(),
    )
  );
}

