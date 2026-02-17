
// 全局的常量
class GlobalConstants {
  static const String BASE_URL = "https://meikou-api.itheima.net"; // 基础地址
  static const int TIME_OUT = 10; // 超时时间 单位是秒
  static const String SUCCESS_CODE = "1"; // 成功状态

  static const String TOKEN_KEY = "hm_stop_token"; // token对应持久化的key
}

// 存放请求地址接口的常量
class HttpConstants{
  static const String BANNER_LIST = "/home/banner"; // 首页轮播图接口
  static const String CATEGORY_LIST = "/home/category/head";  // 首页分类头部列表接口
  static const String PRODUCT_LIST = "/hot/preference"; // 特惠推荐地址
  static const String IN_VOGUE_LIST = "/hot/inVogue"; // 热榜推荐地址
  static const String ONE_STOP_LIST = "/hot/oneStop"; // 一站式推荐地址
  static const String RECOMMEND_LIST = "/home/recommend"; // 推荐列表地址
  static const String GUESS_LIST = "/home/goods/guessLike"; // 猜你喜欢地址
  static const String LOGIN = "/login"; // 登陆地址
  static const String USER_PROFILE = "/member/profile"; // 用户信息接口地址
}