import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '/utils/colors.dart';
import '/utils/margin_padding.dart';

class ShimmerLoaderWidget extends StatelessWidget {
  final int rowRequired;

  const ShimmerLoaderWidget({required this.rowRequired});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: MarginPadding.MARGIN_SYMMETRIC_10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                for (int i = 0; i < rowRequired; i++) _getShimmerRowWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //Get Shimmer Row
  Widget _getShimmerRowWidget() {
    return Container(
      child: Column(
        children: [
          Shimmer.fromColors(
            period: Duration(milliseconds: 3000),
            baseColor: MyColors.grey, //Color(0xff7f00ff),
            highlightColor:
                MyColors.white.withOpacity(0.1), //Color(0xffe100ff),
            child: Container(
              color: MyColors.greyLight,
              width: double.infinity,
              padding: EdgeInsets.all(10.0),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
