import 'package:flutter/material.dart';
import '../model/contactModel.dart' show ContactModel, ContactModelData, INDEX_BAR_WORDS;
import '../others/colors/colors.dart' show AppColor;
import '../others/tools/constant.dart' show AppTextStyle, Constants;

class ContactPageWidget extends StatefulWidget {
  Color _indexBarBgColor = Colors.transparent;
  String _currentLetter = '';
  @override
  ContactPageWidgetState createState() => ContactPageWidgetState();
}

/*通讯录入口*/
class ContactPageWidgetState extends State<ContactPageWidget> {
  final List<ContactModel> _contacts = [];
  List<Widget> _indexWidgets;
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

  /*存储每个字母分组的位置*/
  final Map _letterPositionMap = {INDEX_BAR_WORDS[0]: 0.0};

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _contacts..addAll(ContactModelData.contactsList);
    _contacts..sort((ContactModel cm1, ContactModel cm2) => cm1.nameIndex.compareTo(cm2.nameIndex));
    _indexWidgets = INDEX_BAR_WORDS.map((String title) {
      return Expanded(
        child: Text(title),
      );
    }).toList();
    /*计算用于 IndexBar 进行定位的关键通讯录列表项的位置*/
    var _totalHeight = _contactButtonsList.length * Constants.ContactCellHeight;
    for(int i = 0; i < _contacts.length; i ++) {
      bool _hasGroupTitle = true;
      if (i > 0 && _contacts[i].nameIndex.compareTo(_contacts[i - 1].nameIndex) == 0) {
        _hasGroupTitle = false;
      }
      if (_hasGroupTitle) {
        _letterPositionMap[_contacts[i].nameIndex] = _totalHeight;
      }
      _totalHeight += _ContactItemWidget._height(_hasGroupTitle);
    }
  }

  String _getLetter(BuildContext context, double tileHeight, Offset globalPos) {
    RenderBox _box = context.findRenderObject();
    var local = _box.globalToLocal(globalPos);
    int index = (local.dy ~/ tileHeight).clamp(0, INDEX_BAR_WORDS.length - 1);
    return INDEX_BAR_WORDS[index];
  }

  void _jumpToIndex(String letter) {
    if (_letterPositionMap.isNotEmpty) {
      final _pos = _letterPositionMap[letter];
      if (_pos != null) {
        _scrollController.animateTo(_pos,
            curve: Curves.easeOut, duration: Duration(milliseconds: 200));
      }
    }
  }

  Widget _buildIndexBar(BuildContext context, BoxConstraints constraints) {

    final double _totalHeight = constraints.biggest.height;
    final double _tileHeight = _totalHeight / _indexWidgets.length;

    return GestureDetector(
        onVerticalDragDown: (DragDownDetails d) {
          setState(() {
            widget._indexBarBgColor = Colors.grey[300];
            widget._currentLetter =
                _getLetter(context, _tileHeight, d.globalPosition);
            _jumpToIndex(widget._currentLetter);
          });
        },
        onVerticalDragEnd: (DragEndDetails d) {
          setState(() {
            widget._indexBarBgColor = Colors.transparent;
            widget._currentLetter = null;
          });
        },
        onVerticalDragCancel: () {
          setState(() {
            widget._indexBarBgColor = Colors.transparent;
            widget._currentLetter = null;
          });
        },
        onVerticalDragUpdate: (DragUpdateDetails d) {
          setState(() {
            widget._indexBarBgColor = Colors.grey[300];
            widget._currentLetter =
                _getLetter(context, _tileHeight, d.globalPosition);
            _jumpToIndex(widget._currentLetter);
          });
        },
        child: Column(
          children: this._indexWidgets
        ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          ListView.builder(
            controller: _scrollController,
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
          Positioned(
            width: 30.0,
            top: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
                color: widget._indexBarBgColor,
                child: LayoutBuilder(
                  builder: _buildIndexBar,
                )
            ),
          ),
          Center(
            child: (widget._currentLetter != null && widget._currentLetter.isNotEmpty) ? Card(
              color: Colors.grey.withOpacity(0.5),
              child: Container(
                alignment: Alignment.center,
                width: 120.0,
                height: 120.0,
                child: Text(widget._currentLetter,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40
                  ),
                ),
              ),
            ) : null
          ),
        ],
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

  /*计算每个cell的高度（有group和没有group）*/
  static double _height(bool hasGroup) {
    if (hasGroup) {
      return Constants.ContactHeaderHeight + Constants.ContactCellHeight;
    }
    return Constants.ContactCellHeight;
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
      height: Constants.ContactHeaderHeight,
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
        height: Constants.ContactCellHeight,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Container(
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
