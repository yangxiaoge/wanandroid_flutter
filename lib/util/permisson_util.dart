import 'package:flutter/material.dart';
import 'dart:io';
import '../constant/component_index.dart';

class PermissionUtil {
  static Future<bool> deal(List<PermissionGroup> permissions) async {
    Map<PermissionGroup, PermissionStatus> statusMap =
        await PermissionHandler().requestPermissions(permissions);
    print(statusMap);

    String tipContent = ' ';

    bool result = true;
    statusMap.forEach((permissionGroup, permissionStatus) {
      if (permissionStatus != PermissionStatus.granted) {
        tipContent += configMap.containsKey(permissionGroup)
            ? configMap[permissionGroup] + ' '
            : '';
        result = false;
      }
    });

    if (!result) {
      print('权限被拒绝');
      showDialog(
          context: Constants.mContext,
          // barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text('权限不足'),
              content: Text('请前往设置打开 [ $tipContent ]权限'),
              actions: <Widget>[
                FlatButton(
                  child: Text('确认'),
                  onPressed: () {
                    PermissionHandler().openAppSettings();
                    ToastUtil.showToast('关闭应用');
                    exit(0);
                  },
                )
              ],
            );
          });
    } else {
      print('all permissions granted!');
    }
    return result;
  }

  static Map<PermissionGroup, String> configMap = {
    PermissionGroup.photos: '相册',
    PermissionGroup.camera: '相机',
    PermissionGroup.contacts: '联系人',
    PermissionGroup.location: '位置',
    PermissionGroup.microphone: '麦克风',
    PermissionGroup.storage: '存储',
    PermissionGroup.speech: '讲话',
    PermissionGroup.phone: '电话',
  };
}
