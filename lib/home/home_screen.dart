import 'package:flutter/material.dart';
import '../others/colors/colors.dart' show AppColor;
import '../others/tools/constant.dart' show AppFontFamily;
import '../home/conversation_page.dart' show ConversationPageWidget;
import '../home/contact_page.dart' show ContactPageWidget;

class HomePageWidget extends StatefulWidget {
  @override
  HomePageWidgetState createState() => HomePageWidgetState();
}

class HomePageWidgetState extends State<HomePageWidget> {
  List<NavigationViewIcon> _naviIconList;
  /*底部导航栏的当前索引*/
  int _bottomBarIndex = 0;
  /*pageController*/
  PageController _pageController;
  /*pages*/
  List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _naviIconList = [
      NavigationViewIcon(
        title: '微信',
        icon: Icon(IconData(
            0xe608,
            fontFamily: AppFontFamily.IconFontFamily
        )),
        activeIcon: Icon(IconData(
            0xe603,
            fontFamily: AppFontFamily.IconFontFamily
        )),
      ),
      NavigationViewIcon(
        title: '通讯录',
        icon: Icon(IconData(
            0xe601,
            fontFamily: AppFontFamily.IconFontFamily
        )),
        activeIcon: Icon(IconData(
            0xe656,
            fontFamily: AppFontFamily.IconFontFamily
        )),
      ),
      NavigationViewIcon(
        title: '发现',
        icon: Icon(IconData(
            0xe600,
            fontFamily: AppFontFamily.IconFontFamily
        )),
        activeIcon: Icon(IconData(
            0xe671,
            fontFamily: AppFontFamily.IconFontFamily
        )),
      ),
      NavigationViewIcon(
        title: '我',
        icon: Icon(IconData(
            0xe6c0,
            fontFamily: AppFontFamily.IconFontFamily
        )),
        activeIcon: Icon(IconData(
            0xe626,
            fontFamily: AppFontFamily.IconFontFamily
        )),
      ),
    ];

    _pageController = PageController(initialPage: _bottomBarIndex);

    _pages = [
      ConversationPageWidget(),
      ContactPageWidget(),
      Container(color: Colors.orange),
      Container(color: Colors.cyan),
    ];
  }

  @override
  Widget build(BuildContext context) {
    /*底部导航栏*/
    final BottomNavigationBar bottomBar = BottomNavigationBar(
      items: _naviIconList.map((NavigationViewIcon iconView) => iconView.item).toList(),
      currentIndex: _bottomBarIndex,
      onTap: (int index) {
        setState(() {
          _bottomBarIndex = index;
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut
          );
        });
      },
      type: BottomNavigationBarType.fixed,
      fixedColor: AppColor.TabItemActiveColor,
      selectedFontSize: 12.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('微信'),
        actions: <Widget>[
          PopupMenuButton(
            offset: Offset(-60.0, 90.0),
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<PopActionValues>>[
                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe69e, '发起群聊'),
                  value: PopActionValues.GROUP_CHAT,
                ),
                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe638, '添加朋友'),
                  value: PopActionValues.ADD_FRIENDS,
                ),
                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe61b, '扫一扫'),
                  value: PopActionValues.SCAN_SCAN,
                ),
                PopupMenuItem(
                  child: _buildPopupMenuItem(0xe62a, '收付款'),
                  value: PopActionValues.PAY_MONEY,
                ),
              ];
            },
            icon: Icon(IconData(
                0xe600,
                fontFamily: AppFontFamily.IconFontFamily
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
          ),
        ],
      ),
      body: PageView.builder(
        itemCount: _pages.length,
        itemBuilder: (BuildContext context, int index) {
          return _pages[index];
        },
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _bottomBarIndex = index;
          });
        },
      ),
      bottomNavigationBar: bottomBar,
    );
  }

  /*气泡菜单Item*/
  Widget _buildPopupMenuItem(int iconName, String title) {
    return Row(
      children: <Widget>[
        Padding(padding: const EdgeInsets.only(left: 3.0)),
        Icon(IconData(
          iconName,
          fontFamily: AppFontFamily.IconFontFamily,
        ), color: Colors.white),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0)),
        Text(title, style: TextStyle(color: Colors.white))
      ],
    );
  }
  
}

/*bottom导航菜单栏的Item*/
class NavigationViewIcon {
  NavigationViewIcon({Key key, String title, Icon icon, Icon activeIcon}):
      _title = title,
      _icon = icon,
      _activeIcon = activeIcon,
      item = BottomNavigationBarItem(
        icon: icon,
        activeIcon: activeIcon,
        title: Text(title),
        backgroundColor: Colors.white
      );

  final String _title;
  final Icon _icon;
  final Icon _activeIcon;
  final BottomNavigationBarItem item;
}

/*气泡菜单的value枚举*/
enum PopActionValues {
  GROUP_CHAT,
  ADD_FRIENDS,
  SCAN_SCAN,
  PAY_MONEY
}