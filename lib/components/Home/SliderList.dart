import 'package:flutter/material.dart';

class SliderList extends StatefulWidget {
  const SliderList({super.key});

  @override
  State<SliderList> createState() => _SliderListState();
}

class _SliderListState extends State<SliderList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.blue,
      alignment: Alignment.center,
      child:Text("轮播图",style: TextStyle(color: Colors.white,fontSize: 20)));
  }
}