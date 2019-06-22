import 'package:flutter/material.dart';
import '../common/commonButton.dart' show CommonButtonWidget;
import '../others/colors/colors.dart';

const SEPARATE_SIZE = 20.0;

class DiscoverPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.ConversationDeviceInfoBgColor,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CommonButtonWidget(
              iconName: 'assets/images/ic_social_circle.png',
              title: "朋友圈",
              onPressed: () {
                print('点击朋友圈');
              },
            ),
            SizedBox(height: SEPARATE_SIZE),
            CommonButtonWidget(
              iconName: 'assets/images/ic_quick_scan.png',
              title: '扫一扫',
              hasDeliver: true,
              onPressed: () {
                print('点击了扫一扫');
              },
            ),
            CommonButtonWidget(
              iconName: 'assets/images/ic_shake_phone.png',
              title: '摇一摇',
              onPressed: () {},
            ),
            SizedBox(height: SEPARATE_SIZE),
            CommonButtonWidget(
              iconName: 'assets/images/ic_feeds.png',
              title: '看一看',
              hasDeliver: true,
              onPressed: () {},
            ),
            CommonButtonWidget(
              iconName: 'assets/images/ic_quick_search.png',
              title: '搜-搜',
              onPressed: () {},
            ),
            SizedBox(height: SEPARATE_SIZE),
            CommonButtonWidget(
              iconName: 'assets/images/ic_people_nearby.png',
              title: '附近的人',
              hasDeliver: true,
              onPressed: () {},
            ),
            CommonButtonWidget(
              iconName: 'assets/images/ic_bottle_msg.png',
              title: '漂流瓶',
              onPressed: () {},
            ),
            SizedBox(height: SEPARATE_SIZE),
            CommonButtonWidget(
              iconName: 'assets/images/ic_shopping.png',
              title:'购物',
              hasDeliver: true,
              onPressed: () {},
            ),
            CommonButtonWidget(
              iconName: 'assets/images/ic_game_entry.png',
              title: '游戏',
              onPressed: () {},
            ),
            SizedBox(height: SEPARATE_SIZE),
            CommonButtonWidget(
              iconName: 'assets/images/ic_mini_program.png',
              title: '小程序',
              onPressed: () {},
            ),
            SizedBox(height: SEPARATE_SIZE),
          ],
        ),
      ),
    );
  }
}

