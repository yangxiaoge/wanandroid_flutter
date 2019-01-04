import 'package:flutter/material.dart';
import '../constant/constants.dart' show Constants, AppColors;
import '../util/toast_util.dart';

enum PopMenuItems { GROUP_CHAT, ADD_FRIEND, QR_SCAN, PAYMENT, HELP }

class PopUpMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final statsBarPlusAppbarHeight =
        MediaQuery.of(context).padding.top + kToolbarHeight;

    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: _buildPopupMunuItem(0xe69e, "发起群聊"),
            value: PopMenuItems.GROUP_CHAT,
          ),
          PopupMenuItem(
            child: _buildPopupMunuItem(0xe638, "添加朋友"),
            value: PopMenuItems.ADD_FRIEND,
          ),
          PopupMenuItem(
            child: _buildPopupMunuItem(0xe61b, "扫一扫"),
            value: PopMenuItems.QR_SCAN,
          ),
          PopupMenuItem(
            child: _buildPopupMunuItem(0xe62a, "收付款"),
            value: PopMenuItems.PAYMENT,
          ),
          PopupMenuItem(
            child: _buildPopupMunuItem(0xe63d, "帮助与反馈"),
            value: PopMenuItems.HELP,
          ),
        ];
      },
      icon: Icon(Icons.more_vert),
      onSelected: (action) {
        print('点击了 $action');
        ToastUtil.showToast("点击了 $action");
      },
      offset: Offset(0, statsBarPlusAppbarHeight),
    );
  }
}

_buildPopupMunuItem(int iconName, String title) {
  return Row(
    children: <Widget>[
      Icon(
          IconData(
            iconName,
            fontFamily: Constants.IconFontFamily,
          ),
          size: 22.0,
          color: Color(AppColors.AppBarPopupMenuColor)),
      Container(width: 12.0),
      Text(title,
          style: TextStyle(color: Color(AppColors.AppBarPopupMenuColor))),
    ],
  );
}
