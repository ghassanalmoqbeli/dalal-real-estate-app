import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/widgets/custom_app_bar.dart';
import 'package:dallal_proj/features/favorite_page/presentation/views/widgets/favorite_grid_view_bloc_builder.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key, required this.token});
  final String token;
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: kFav),
      body: Padding(
        padding: EdgeInsets.only(right: 10, left: 10),
        child: FavoriteGridViewBlocBuilder(),
      ),
    );
  }
}
