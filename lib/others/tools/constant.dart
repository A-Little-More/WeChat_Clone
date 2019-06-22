import 'package:flutter/material.dart';
import '../colors/colors.dart' show AppColor;

class AppFontFamily {
  static const IconFontFamily = "appIconFont";/*矢量图标family*/
}

class Constants {
  static const ConversationAvatarWidth = 50.0;/*会话列表头像大小*/
  static const ConversationAvatarHeight = 50.0;/*会话列表头像大小*/
  static const ConversationTitleSize = 16.0;
  static const ConversationSubtitleSize = 13.0;
  static const ConversationDotSize = 18.0;
  static const ConversationDotTextSize = 10.0;
  static const ConversationMuteIconSize = 18.0;
  static const ConversationDeviceSliverWidth = 0.6;
  static const ContactCellHeight = 65.0;
  static const ContactHeaderHeight = 30.0;
}

class AppTextStyle {
  static const TitleStyle = TextStyle(
    fontSize: Constants.ConversationTitleSize,
    color: AppColor.ConversationTitleColor,
  );
  static const SubtitleStyle = TextStyle(
    fontSize: Constants.ConversationSubtitleSize,
    color: AppColor.ConversationSubtitleColor,
  );
  static const DotStyle = TextStyle(
    fontSize: Constants.ConversationDotTextSize,
    color: AppColor.ConversationDotColor,
  );
  static const DeviceInfoItemTextStyle = TextStyle(
    fontSize: Constants.ConversationSubtitleSize,
    color: AppColor.ConversationDeviceInfoTitleColor,
  );
  static const GroupTitleItemTextStyle = TextStyle(
    fontSize: 14.0,
    color: AppColor.ContactGroupTitleTextColor,
  );
}
