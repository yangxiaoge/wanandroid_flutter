/// 玩Android api 接口页 ：http://www.wanandroid.com/blog/show/2
class WanApi {
  ///baseurl, 升级为https了！
  static const String BaseUrl = "https://www.wanandroid.com/";

  ///公众号列表
  static const String WXAccounts = "wxarticle/chapters/json";

  ///查看某个公众号历史数据
  static const String WXAcountArticles = "wxarticle/list/";

  ///最新项目 tab (首页的第二个 tab) http://wanandroid.com/article/listproject/0/json
  static const String DISCOVER_LIST_PROJECT = "article/listproject/";

  ///1.1 首页文章列表
  static const String Home_Article_List = "article/list/";

  ///1.2 首页 banner
  static const String Banner = "banner/json";

  ///1.3 常用网站
  static const String Friend = "friend/json";

  ///1.4 搜索热词
  static const String HotKey = "hotkey/json";

  ///2.1 体系数据
  static const String TREE = "tree/json";

  ///5.1 登录
  static const String LOGIN = "user/login";

  ///5.2 注册
  static const String REGISTER = "user/register";

  ///5.3 退出
  static const String LogOut = "user/logout/";

  ///6.1 收藏文章列表
  static const String COLLECT_LIST = "lg/collect/list/";

  ///6.2 收藏
  static const String COLLECT = "lg/collect/";

  ///6.4 文章列表-取消收藏
  static const String UNCOLLECT_ORIGINID = "lg/uncollect_originId/";

  ///6.4.2 我的收藏页面-取消收藏
  static const String UNCOLLECT_LIST = "lg/uncollect/";

  ///7.1 搜索
  static const String ARTICLE_QUERY = "article/query/";
}

///干货集中营 https://gank.io/api
class GankIO {
  ///GankIO baseurl
  static const String BaseUrl = "http://gank.io/api/";

  ///妹子， http://gank.io/api/data/福利/10/1
  static const String MEIZI = "data/福利";
}
