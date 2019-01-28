import '../constant/component_index.dart';

class ImageUtil {
  static Widget getImage(String url, {BoxFit fit: BoxFit.scaleDown}) {
    if (url.startsWith("http")) {
      ///网络图片
      return CachedNetworkImage(
        imageUrl: url,
      );
    } else {
      ///本地资源图片
      return Image.asset(
        url,
        fit: fit,
      );
    }
  }

  static ImageProvider<dynamic> getImageProvider(String url) {
    if (url.startsWith("http")) {
      ///网络图片
      return CachedNetworkImageProvider(url);
    } else {
      ///本地资源图片
      return AssetImage(url);
    }
  }
}
