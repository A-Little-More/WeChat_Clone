import 'package:flutter/material.dart';

class UserInfoButtonWidget extends StatelessWidget {

  const UserInfoButtonWidget({Key key, String avatar, String name, String wechatNo})
  : assert(avatar != null),
    assert(name != null),
    assert(wechatNo != null),
    _avatar = avatar,
    _name = name,
    _wechatNo = wechatNo,
    super(key: key);

  final String _avatar;
  final String _name;
  final String _wechatNo;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image.network(this._avatar,
              width: 80.0,
              height: 80.0,
            ),
          ),
          SizedBox(width: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(this._name,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10.0),
              Text(this._wechatNo,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15.0,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}