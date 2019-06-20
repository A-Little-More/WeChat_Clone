import 'package:flutter/material.dart';
import '../model/contactModel.dart' show ContactModel, ContactModelData;
import '../others/colors/colors.dart' show AppColor;
import '../others/tools/constant.dart' show AppTextStyle, Constants;

class ContactPageWidget extends StatefulWidget {
  @override
  ContactPageWidgetState createState() => ContactPageWidgetState();
}

/*通讯录入口*/
class ContactPageWidgetState extends State<ContactPageWidget> {
  final List<ContactModel> _contacts = [];
  final List<_ContactItemWidget> _contactButtonsList = [
    _ContactItemWidget(
        avatar: 'assets/images/ic_new_friend.png',
        name: '新的朋友',
        onPressed: () {
          print('添加新朋友。');
        }),
    _ContactItemWidget(
        avatar: 'assets/images/ic_group_chat.png',
        name: '群聊',
        onPressed: () {
          print('点击了群聊。');
        }),
    _ContactItemWidget(
        avatar: 'assets/images/ic_tag.png',
        name: '标签',
        onPressed: () {
          print('标签。');
        }),
    _ContactItemWidget(
        avatar: 'assets/images/ic_public_account.png',
        name: '公众号',
        onPressed: () {
          print('添加公众号。');
        }),
  ];

  @override
  void initState() {
    super.initState();
    _contacts..addAll(ContactModelData.contactsList);
    _contacts..sort((ContactModel cm1, ContactModel cm2) => cm1.nameIndex.compareTo(cm2.nameIndex));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          if (index < _contactButtonsList.length) {
            return _contactButtonsList[index];
          }
          int contactIndex = index - _contactButtonsList.length;
          ContactModel contactModel = _contacts[contactIndex];
          bool isGroupTitle = true;
          if (contactIndex >= 1 && contactModel.nameIndex == _contacts[contactIndex - 1].nameIndex) {
            isGroupTitle = false;
          }
          return _ContactItemWidget(
            avatar: contactModel.avatar,
            name: contactModel.name,
            nameIndex: isGroupTitle ? contactModel.nameIndex : null,
          );
        },
        itemCount: _contacts.length + _contactButtonsList.length,
      ),
    );
  }
}

/*通讯录item*/
class _ContactItemWidget extends StatelessWidget {
  _ContactItemWidget({Key key, String avatar, String name, String nameIndex, VoidCallback onPressed})
  : _avatar = avatar,
    _name = name,
    _nameIndex = nameIndex,
    _onPressed = onPressed,
    super(key: key);

  final String _avatar;
  final String _name;
  final String _nameIndex;
  final VoidCallback _onPressed;

  bool get avatarIsFromNet {
    if (this._avatar.indexOf("http") == 0 || this._avatar.indexOf("https") == 0) {
      return true;
    }
    return false;
  }

  Widget _imageWidget(BuildContext context) {
    if (this.avatarIsFromNet) {
      return Image.network(this._avatar,
        width: Constants.ConversationAvatarWidth,
        height: Constants.ConversationAvatarHeight,
      );
    } else {
      return Image.asset(this._avatar,
        width: Constants.ConversationAvatarWidth,
        height: Constants.ConversationAvatarHeight,
      );
    }
  }

  Widget _groupHeaderWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 15.0),
      color: Colors.grey[200],
      alignment: Alignment.centerLeft,
      child: Text(this._nameIndex,
        style: AppTextStyle.GroupTitleItemTextStyle,
      ),
    );
  }

  Widget _contactWidget(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: AppColor.ConversationSliverColor,
                    width: 0.4
                )
            ),
          ),
          child: Row(
            children: <Widget>[
              _imageWidget(context),
              SizedBox(
                width: 15.0,
              ),
              Text(this._name,
                style: AppTextStyle.TitleStyle,
              ),
            ],
          ),
        )
    );
  }

  Widget _sectionWidget(BuildContext context) {
    return Container(
      child: Column(
        children: this._nameIndex != null ? [
          _groupHeaderWidget(context),
          _contactWidget(context),
        ] : [_contactWidget(context)]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _sectionWidget(context);
  }
}
