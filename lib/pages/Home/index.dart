import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/Category.dart';
import 'package:hm_shop/components/Home/Hot.dart';
import 'package:hm_shop/components/Home/MoreList.dart';
import 'package:hm_shop/components/Home/SliderList.dart';
import 'package:hm_shop/components/Home/Suggestion.dart';
import 'package:hm_shop/utils/ToastUtils.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // 轮播图列表数据
  List<BannerItem> _bannerList = [];
  // 分类列表数据
  List<CategoryItem> _categoryList = [];
  //特惠推荐数据
  SpecialRecommendResult _specialRecommendResult = SpecialRecommendResult(
    id: '',
    title: "",
    subTypes: [],
  );
  // 热榜推荐数据
  SpecialRecommendResult _inVogueResult = SpecialRecommendResult(
    id: '',
    title: "",
    subTypes: [],
  );
  // 一站式推荐数据
  SpecialRecommendResult _oneStopsResult = SpecialRecommendResult(
    id: '',
    title: "",
    subTypes: [],
  );
  // 推荐列表数据
  List<GoodDetailItem> _recommendList = [];

  // 滚动控制器
  final ScrollController _scrollController = ScrollController();
  // 页码
  int _page = 1;
  // 是否正在加载更多数据，用于同一时间只能加载一次数据，防止多次加载
  bool _isLoadingMore = false;
  // 是否还有下一页
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _registerListener();
    _paddingTop = 100;
    setState(() {});
    // 必须放在微任务里面
    Future.microtask(() {
      // initState => build => 下拉刷新组件 => 才可以操作它（_refreshIndicatorKey）
      _refreshIndicatorKey.currentState?.show(); // 会调用自动调用_onRefresh
    });
  }

  // 注册监听
  void _registerListener() {
    _scrollController.addListener(() {
      // 滚动到底部的最大距离
      double maxValue = _scrollController.position.maxScrollExtent;
      // 当前滚动距离
      double currentValue = _scrollController.position.pixels;
      // 滚动到距离底部50距离时加载更多数据
      if (currentValue >= (maxValue - 50)) {
        _getRecommendList();
      }
    });
  }

  // 获取轮播图列表数据
  Future<void> _getBannerList() async {
    _bannerList = await getBannerListAPI();
    // setState(() {});
  }

  // 获取分类列表数据
  Future<void> _getCategoryList() async {
    _categoryList = await getCategoryListAPI();
    // setState(() {});
  }

  // 获取特惠推荐数据
  Future<void> _getSpecialRecommend() async {
    _specialRecommendResult = await getProductListAPI();
    // setState(() {});
  }

  // 获取热榜推荐数据
  Future<void> _getInVogue() async {
    _inVogueResult = await getInVogueListAPI();
    // setState(() {});
  }

  // 获取一站式推荐数据
  Future<void> _getOneStops() async {
    _oneStopsResult = await getOneStopListAPI();
    // setState(() {});
  }

  // 获取推荐列表数据
  Future<void> _getRecommendList() async {
    if (_isLoadingMore || !_hasMore) {
      // 如果正在加载更多数据 或者 已经没用下一页了 ，就放弃请求直接返回
      return;
    }

    _isLoadingMore = true; // 开始加载更多数据
    int requestLimit = _page * 8;
    _recommendList = await getRecommendListAPI({"limit": requestLimit});
    _isLoadingMore = false; // 加载更多数据完成
    // 这里涉及下拉刷新多次请求数据 需要更新UI界面，重新渲染数据
    setState(() {});

    // 判断是否还有下一页，判断条件：如果返回的数据长度小于请求的长度，则没有下一页
    if (_recommendList.length < requestLimit) {
      _hasMore = false;
      return;
    }

    _page++;
  }

  // 获取滚动容器的内容
  List<Widget> _getScrollChildren() {
    return [
      // 包裹普通widget的sliver家族的组件
      SliverToBoxAdapter(child: SliderList(bannerList: _bannerList)), // 轮播图组件
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      // 放置分类组件
      // SliverGrid SliverList只能纵向排列
      // 所以只能ListView
      SliverToBoxAdapter(child: Category(categoryList: _categoryList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      // 推荐组件
      SliverToBoxAdapter(
        child: Suggestion(specialRecommendResult: _specialRecommendResult),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      // 爆款推荐组件
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: Hot(result: _inVogueResult, type: "hot"),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Hot(result: _oneStopsResult, type: "step"),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),

      // 无限滚动列表
      MoreList(recommendList: _recommendList),
    ];
  }

  // 下拉刷新事件功能方法
  Future<void> _onRefresh() async {
    _page = 1;
    _hasMore = true;
    _isLoadingMore = false;
    await _getBannerList();
    await _getCategoryList();
    await _getSpecialRecommend();
    await _getInVogue();
    await _getOneStops();
    await _getRecommendList();
    // 数据获取成功，意味着刷新成功
    Toastutils.showToast(context, "刷新成功");

    // 刷新成功后，重置填充高度
    _paddingTop = 0;
    setState(() {});
  }

  // GlobalKey是一个方法可以创建一个key绑定到widget部件上， 可以操作Widget部件
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  // 下拉刷新时，填充的高度, 用于动画效果
  double _paddingTop = 0;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      // 顶部下拉刷新组件
      onRefresh: _onRefresh,
      child: AnimatedContainer(
        padding: EdgeInsets.only(top: _paddingTop), // 顶部填充高度，下拉刷新时填充的高度
        duration: Duration(milliseconds: 300),
        child: CustomScrollView(
          controller: _scrollController, // 绑定滚动控制器
          slivers: _getScrollChildren(),
        ),
      ),
    );
  }
}
