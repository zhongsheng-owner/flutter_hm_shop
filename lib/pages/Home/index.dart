import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/Home/Category.dart';
import 'package:hm_shop/components/Home/Hot.dart';
import 'package:hm_shop/components/Home/MoreList.dart';
import 'package:hm_shop/components/Home/SliderList.dart';
import 'package:hm_shop/components/Home/Suggestion.dart';
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
    _getBannerList();
    _getCategoryList();
    _getSpecialRecommend();
    _getInVogue();
    _getOneStops();
    _getRecommendList();
    _registerListener();
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
  void _getBannerList() async {
    _bannerList = await getBannerListAPI();
    setState(() {});
  }

  // 获取分类列表数据
  void _getCategoryList() async {
    _categoryList = await getCategoryListAPI();
    setState(() {});
  }

  // 获取特惠推荐数据
  void _getSpecialRecommend() async {
    _specialRecommendResult = await getProductListAPI();
    setState(() {});
  }

  // 获取热榜推荐数据
  void _getInVogue() async {
    _inVogueResult = await getInVogueListAPI();
    setState(() {});
  }

  // 获取一站式推荐数据
  void _getOneStops() async {
    _oneStopsResult = await getOneStopListAPI();
    setState(() {});
  }

  // 获取推荐列表数据
  void _getRecommendList() async {
    if (_isLoadingMore || !_hasMore) {
      // 如果正在加载更多数据 或者 已经没用下一页了 ，就放弃请求直接返回
      return;
    }

    _isLoadingMore = true; // 开始加载更多数据
    int requestLimit = _page * 8;
    _recommendList = await getRecommendListAPI({"limit": requestLimit});
    _isLoadingMore = false; // 加载更多数据完成
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

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController, // 绑定滚动控制器
      slivers: _getScrollChildren(),
    );
  }
}
