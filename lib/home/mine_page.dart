import 'package:flutter/material.dart';
import '../common/userInfoButton.dart';
import '../others/colors/colors.dart';
import '../common/commonButton.dart' show CommonButtonWidget;

const SEPARATE_SIZE = 12.0;

class MinePageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.ConversationDeviceInfoBgColor,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            UserInfoButtonWidget(
              avatar: 'https://randomuser.me/api/portraits/men/74.jpg',
              name: 'The Girl Is Lost',
              wechatNo: '微信号：lidong521007',
            ),
            SizedBox(height: SEPARATE_SIZE),
            CommonButtonWidget(
              iconName: 'assets/images/ic_wallet.png',
              title: '钱包',
              onPressed: () {
                print('点击的是钱包按钮。');
              },
            ),
            SizedBox(height: SEPARATE_SIZE),
            CommonButtonWidget(
              iconName: 'assets/images/ic_collections.png',
              title: '收藏',
              hasDeliver: true,
              onPressed: () {
                print('点击的是收藏按钮。');
              },
            ),
            CommonButtonWidget(
              iconName: 'assets/images/ic_album.png',
              title: '相册',
              hasDeliver: true,
              onPressed: () {
                print('点击的是相册按钮。');
              },
            ),
            CommonButtonWidget(
              iconName: 'assets/images/ic_cards_wallet.png',
              title: '卡包',
              hasDeliver: true,
              onPressed: () {
                print('打开卡包应用');
              },
            ),
            CommonButtonWidget(
              iconName: 'assets/images/ic_emotions.png',
              title: '表情',
              onPressed: () {
                print('打开表情应用');
              },
            ),
            SizedBox(height: SEPARATE_SIZE),
            CommonButtonWidget(
              iconName: 'assets/images/ic_settings.png',
              title: '设置',
              subtitle: '新消息',
              onPressed: () {
                print('打开设置');
              },
            ),
          ],
        ),
      ),
    );
  }
}