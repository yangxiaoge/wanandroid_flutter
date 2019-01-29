//字符串获取 :
//IntlUtil.getString(context, StringIds.titleHome);　
//CustomLocalizations.of(context).getString(StringIds.titleHome)

///多语言资源id管理类.
class Ids {
  //main.dart  gloable
  static String errorWidgetMsg = "Flutter has gone wrong😹";
  static String more = 'more';
  static String noMore = "in the end~";
  
  //splash
  static String skip = "Skip";
  static String welcome = "Welcome";

  //bottom tab
  static String titleHome = 'title_home';
  static String titleDiscover = 'title_discover';
  static String titleWelfare = 'title_welfare';
  static String titleMine = 'title_mine';

  //drawer
  static String drawer = 'Drawer';
  static String titleCollection = 'title_collection';
  static String titleSetting = 'title_setting';
  static String titleAbout = 'title_about';
  static String titleWeather = 'title_weather';
  static String titleShare = 'title_share';
  static String titleSignOut = 'title_signout';

  //home_page
  static String collectSuccess = "Successful collection";
  static String cancelCollect = "Cancel collection";
  static String notLogin = "Please log in first";
  //meizi_page
  static String loadingMore = "load more...";
  //mine_page
  static String userOrPwdNull = "Account or password cannot be empty";
  static String userName = "UserName";  
  static String pwd = "Password";  
  static String login = "Login";
  static String register = "Register";

  //search page
  static String search = "search";

  //setting
  static String titleLanguage = 'title_language';
  static String titleTheme = 'title_theme';
  static String save = 'save';

  //about
  static String shareTxt =
      "I found a good app, you can learn technical documentation, and there are also beautiful pictures for you to enjoy😋: https://github.com/yangxiaoge/wanandroid_flutter";
  static String introduction = 'Introduction';
  static String mumuxiDesc =
      "ZZ Play Android, is a Material-style Flutter application, including login, search, collection, discovery, multi-language, theme switching and other functions. \n\n There are sisters waiting for you, just order a Star, thank you for your support!";
  static String sourceCode = "Source code:";
  static String developer = "Developer";
  static String personalWebSite = "Developer Site:";
  static String apiWebSite = "API address:";
  static String referenceProject = "Reference Project:";
  static String openSourceLibrary = "Open source library:";

  //language
  static String languageAuto = 'language_auto';
  static String languageZH = 'language_zh';
  static String languageTW = 'language_tw';
  static String languageHK = 'language_hk';
  static String languageEN = 'language_en';
}

///简单多语言资源
Map<String, Map<String, String>> localizedSimpleValues = {
  'en': {
    Ids.errorWidgetMsg: "Flutter has gone wrong😹",
    Ids.more: 'More',
    Ids.noMore: 'In the end',
    Ids.skip: "Skip",
    Ids.welcome: "Welcome",
    Ids.titleHome: 'Home',
    Ids.titleDiscover: 'Discover',
    Ids.titleWelfare: 'Welfare',
    Ids.titleMine: 'Mine',
    Ids.drawer: 'Drawer',
    Ids.titleCollection: 'Collection',
    Ids.titleSetting: 'Setting',
    Ids.titleAbout: 'About',
    Ids.titleWeather: 'Weather',
    Ids.titleShare: 'Share',
    Ids.titleSignOut: 'Sign Out',
    Ids.collectSuccess: 'Successful collection',
    Ids.cancelCollect: 'Cancel collection',
    Ids.notLogin: 'Please log in first',
    Ids.loadingMore: 'load more...',
    Ids.userOrPwdNull: 'Account or password cannot be empty',
    Ids.userName: 'UserName',
    Ids.pwd: 'Password',
    Ids.login: 'Login',
    Ids.register: 'Register',
    Ids.search: 'Search',
    Ids.titleLanguage: 'Language',
    Ids.titleTheme: 'Theme',
    Ids.languageAuto: 'Auto',
    Ids.shareTxt: 'I found a good app, you can learn technical documentation, and there are also beautiful pictures for you to enjoy😋: https://github.com/yangxiaoge/wanandroid_flutter',
    Ids.introduction: 'Introduction',
    Ids.mumuxiDesc: 'ZZ Play Android, is a Material-style Flutter application, including login, search, collection, discovery, multi-language, theme switching and other functions. \n\n There are sisters waiting for you, just order a Star, thank you for your support!',
    Ids.sourceCode: 'Source code:',
    Ids.developer: 'Developer:',
    Ids.personalWebSite: 'Developer Site:',
    Ids.apiWebSite: 'API address:',
    Ids.referenceProject: 'Reference Project:',
    Ids.openSourceLibrary: 'Open source library:',
  },
  'zh': {
    Ids.errorWidgetMsg: "Flutter 走神了😹",
    Ids.more: '更多',
    Ids.noMore:'到底啦~',
    Ids.skip: "跳过",
    Ids.welcome: "欢迎",
    Ids.titleHome: '主页',
    Ids.titleDiscover: '发现',
    Ids.titleWelfare: '福利',
    Ids.titleMine: '我的',
    Ids.drawer: '抽屜',
    Ids.titleCollection: '收藏',
    Ids.titleSetting: '设置',
    Ids.titleAbout: '关于',
    Ids.titleWeather: '天气',
    Ids.titleShare: '分享',
    Ids.titleSignOut: '注销',
    Ids.collectSuccess: '收藏成功',
    Ids.cancelCollect: '取消收藏',
    Ids.notLogin: '请先登录',
    Ids.loadingMore: '加载更多...',
    Ids.userOrPwdNull: '账号密码不能为空',
    Ids.userName: '用户名',
    Ids.pwd: '密码',
    Ids.login: '登录',
    Ids.register: '注册',
    Ids.search: '搜索',
    Ids.titleLanguage: '多语言',
    Ids.titleTheme: '主題',
    Ids.languageAuto: '跟随系统',
    Ids.shareTxt: '发现了一款不错的应用，可以学习技术文档，同时还有赏心悦目的美图供欣赏😋：https://github.com/yangxiaoge/wanandroid_flutter',
    Ids.introduction: '简介',
    Ids.mumuxiDesc: 'ZZ玩Android，是一款Material风格的Flutter应用，包含登录，搜索，收藏，发现，多语言，主题切换等功能。\n\n此外还有妹子等你哦，顺手点个Star，感谢支持！',
    Ids.sourceCode: '项目源码:',
    Ids.developer: '开发者:',
    Ids.personalWebSite: '个人主页:',
    Ids.apiWebSite: 'API地址:',
    Ids.referenceProject: '参考项目:',
    Ids.openSourceLibrary: '开源库:',
  },
};

///多语言资源
Map<String, Map<String, Map<String, String>>> localizedValues = {
  'en': {
    'US': {
      Ids.errorWidgetMsg: "Flutter has gone wrong😹",
      Ids.more: 'More',
      Ids.noMore: 'In the end',
      Ids.skip: "Skip",
      Ids.welcome: "Welcome",
      Ids.titleHome: 'Home',
      Ids.titleDiscover: 'Discover',
      Ids.titleWelfare: 'Welfare',
      Ids.titleMine: 'Mine',
      Ids.drawer: 'Drawer',
      Ids.titleCollection: 'Collection',
      Ids.titleSetting: 'Setting',
      Ids.titleAbout: 'About',
      Ids.titleWeather: 'Weather',
      Ids.titleShare: 'Share',
      Ids.titleSignOut: 'Sign Out',
      Ids.collectSuccess: 'Successful collection',
      Ids.cancelCollect: 'Cancel collection',
      Ids.notLogin: 'Please log in first',
      Ids.loadingMore: 'load more...',
      Ids.userOrPwdNull: 'Account or password cannot be empty',
      Ids.userName: 'UserName',
      Ids.pwd: 'Password',
      Ids.login: 'Login',
      Ids.register: 'Register',
      Ids.search: 'Search',
      Ids.titleLanguage: 'Language',
      Ids.titleTheme: 'Theme',
      Ids.languageAuto: 'Auto',
      Ids.save: 'Save',
      Ids.titleTheme: 'Theme',
      Ids.shareTxt: 'I found a good app, you can learn technical documentation, and there are also beautiful pictures for you to enjoy😋: https://github.com/yangxiaoge/wanandroid_flutter',
      Ids.introduction: 'Introduction',
      Ids.mumuxiDesc: 'ZZ Play Android, is a Material-style Flutter application, including login, search, collection, discovery, multi-language, theme switching and other functions. \n\n There are sisters waiting for you, just order a Star, thank you for your support!',
      Ids.sourceCode: 'Source code:',
      Ids.developer: 'Developer:',
      Ids.personalWebSite: 'Developer Site:',
      Ids.apiWebSite: 'API address:',
      Ids.referenceProject: 'Reference Project:',
      Ids.openSourceLibrary: 'Open source library:',
    }
  },
  'zh': {
    'CN': {
      Ids.errorWidgetMsg: "Flutter 走神了😹",
      Ids.more: '更多',
      Ids.noMore:'到底啦~',
      Ids.skip: "跳过",
      Ids.welcome: "欢迎",
      Ids.titleHome: '主页',
      Ids.titleDiscover: '发现',
      Ids.titleWelfare: '福利',
      Ids.titleMine: '我的',
      Ids.drawer: '抽屉',
      Ids.titleCollection: '收藏',
      Ids.titleSetting: '设置',
      Ids.titleAbout: '关于',
      Ids.titleWeather: '天气',
      Ids.titleShare: '分享',
      Ids.titleSignOut: '注销',
      Ids.collectSuccess: '收藏成功',
      Ids.cancelCollect: '取消收藏',
      Ids.notLogin: '请先登录',
      Ids.loadingMore: '加载更多...',
      Ids.userOrPwdNull: '账号密码不能为空',
      Ids.userName: '用户名',
      Ids.pwd: '密码',
      Ids.login: '登录',
      Ids.register: '注册',
      Ids.search: '搜索',
      Ids.titleLanguage: '多语言',
      Ids.titleTheme: '主题',
      Ids.languageAuto: '跟随系统',
      Ids.languageZH: '简体中文',
      Ids.languageTW: '繁體中文（台灣）',
      Ids.languageHK: '繁體中文（香港）',
      Ids.languageEN: 'English',
      Ids.save: '保存',
      Ids.titleTheme: '主题',
      Ids.shareTxt: '发现了一款不错的应用，可以学习技术文档，同时还有赏心悦目的美图供欣赏😋：https://github.com/yangxiaoge/wanandroid_flutter',
      Ids.introduction: '简介',
      Ids.mumuxiDesc: 'ZZ玩Android，是一款Material风格的Flutter应用，包含登录，搜索，收藏，发现，多语言，主题切换等功能。\n\n此外还有妹子等你哦，顺手点个Star，感谢支持！',
      Ids.sourceCode: '项目源码:',
      Ids.developer: '开发者:',
      Ids.personalWebSite: '个人主页:',
      Ids.apiWebSite: 'API地址:',
      Ids.referenceProject: '参考项目:',
      Ids.openSourceLibrary: '开源库:',
    },
    'HK': {
      Ids.errorWidgetMsg: "Flutter 走神了😹",
      Ids.more: '更多',
      Ids.noMore:'到底啦~',
      Ids.skip: "跳過",
      Ids.welcome: "歡迎",
      Ids.titleHome: '主頁',
      Ids.titleDiscover: '發現',
      Ids.titleWelfare: '福利',
      Ids.titleMine: '我的',
      Ids.drawer: '抽屜',
      Ids.titleCollection: '收藏',
      Ids.titleSetting: '設置',
      Ids.titleAbout: '關於',
      Ids.titleWeather: '天氣',
      Ids.titleShare: '分享',
      Ids.titleSignOut: '註銷',
      Ids.collectSuccess: '收藏成功',
      Ids.cancelCollect: '取消收藏',
      Ids.notLogin: '請先登錄',
      Ids.loadingMore: '加載更多...',
      Ids.userOrPwdNull: '賬號密碼不能為空',
      Ids.userName: '用戶名',
      Ids.pwd: '密碼',
      Ids.login: '登錄',
      Ids.register: '註冊', 
      Ids.search: '搜索',
      Ids.titleLanguage: '語言',
      Ids.titleTheme: '主題',
      Ids.languageAuto: '與系統同步',
      Ids.save: '儲存',
      Ids.titleTheme: '主題',
      Ids.shareTxt: '發現了一款不錯的應用，可以學習技術文檔，同時還有賞心悅目的美圖供欣賞😋：https://github.com/yangxiaoge/wanandroid_flutter',
      Ids.introduction: '簡介',
      Ids.mumuxiDesc: 'ZZ玩Android，是一款Material風格的Flutter應用，包含登錄，搜索，收藏，發現，多語言，主題切換等功能。\n\n此外還有妹子等你哦，順手點個Star，感謝支持！',
      Ids.sourceCode: '項目源碼:',
      Ids.developer: '开发者:',
      Ids.personalWebSite: '個人主頁:',
      Ids.apiWebSite: 'API地址:',
      Ids.referenceProject: '參考項目:',
      Ids.openSourceLibrary: '開源庫:',
    },
    'TW': {
      Ids.errorWidgetMsg: "Flutter 走神了😹",
      Ids.more: '更多',
      Ids.noMore:'到底啦~',
      Ids.skip: "跳過",
      Ids.welcome: "歡迎",
      Ids.titleHome: '主頁',
      Ids.titleDiscover: '發現',
      Ids.titleWelfare: '福利',
      Ids.titleMine: '我的',
      Ids.drawer: '抽屉',
      Ids.titleCollection: '收藏',
      Ids.titleSetting: '設置',
      Ids.titleAbout: '關於',
      Ids.titleWeather: '天氣',
      Ids.titleShare: '分享',
      Ids.titleSignOut: '註銷',
      Ids.collectSuccess: '收藏成功',
      Ids.cancelCollect: '取消收藏',
      Ids.notLogin: '請先登錄',
      Ids.loadingMore: '加載更多...',
      Ids.userOrPwdNull: '賬號密碼不能為空',
      Ids.userName: '用戶名',
      Ids.pwd: '密碼',
      Ids.login: '登錄',
      Ids.register: '註冊', 
      Ids.search: '搜索',
      Ids.titleLanguage: '語言',
      Ids.titleTheme: '主題',
      Ids.languageAuto: '與系統同步',
      Ids.save: '儲存',
      Ids.titleTheme: '主題',
      Ids.shareTxt: '發現了一款不錯的應用，可以學習技術文檔，同時還有賞心悅目的美圖供欣賞😋：https://github.com/yangxiaoge/wanandroid_flutter',
      Ids.introduction: '簡介',
      Ids.mumuxiDesc: 'ZZ玩Android，是一款Material風格的Flutter應用，包含登錄，搜索，收藏，發現，多語言，主題切換等功能。\n\n此外還有妹子等你哦，順手點個Star，感謝支持！',
      Ids.sourceCode: '項目源碼:',
      Ids.developer: '开发者:',
      Ids.personalWebSite: '個人主頁:',
      Ids.apiWebSite: 'API地址:',
      Ids.referenceProject: '參考項目:',
      Ids.openSourceLibrary: '開源庫:',
    }
  }
};