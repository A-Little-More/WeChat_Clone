import 'package:flutter/material.dart';
import '../others/tools/constant.dart';
import '../others/colors/colors.dart';

class CommonButtonWidget extends StatelessWidget {
  const CommonButtonWidget({
    Key key,
    @required String iconName,
    @required String title,
    String subtitle,
    bool hasDeliver: false,
    VoidCallback onPressed
  })
  : assert(iconName != null),
    assert(title != null),
    _iconName = iconName,
    _title = title,
    _subtitle = subtitle,
    _hasDeliver = hasDeliver,
    _onPressed = onPressed,
    super(key: key);

  final String _iconName;
  final String _title;
  final String _subtitle;
  final bool _hasDeliver;
  final VoidCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this._onPressed,
      child: Container(
          color: Colors.white,
          height: 60,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: Row(
                    children: <Widget>[
                      Image.asset(this._iconName,
                        width: 30.0,
                        height: 30.0,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(left: 10.0),
                              child: Text(this._title,
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(right: 10.0),
                              child: Text(this._subtitle ?? "",
                                style: TextStyle(fontSize: 14.0, color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]
                ),
              ),
              Positioned(
                left: 38.0,
                right: 0,
                bottom: 0,
                height: _hasDeliver ? 0.4 : 0.0,
                child: Container(
                  color: AppColor.ConversationSliverColor,
                ),
              )
            ],
          )
      ),
    );
  }
}
