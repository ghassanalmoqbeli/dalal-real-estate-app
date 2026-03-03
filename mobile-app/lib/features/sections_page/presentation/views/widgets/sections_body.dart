import 'package:dallal_proj/core/components/app_cards/selection_cards/items/body_cell_cards.dart';
import 'package:dallal_proj/core/components/app_cards/selection_cards/sect_selection_cards/section_cell_card.dart';
import 'package:dallal_proj/features/sections_page/presentation/manager/fetch_apt_list_cubit/fetch_apt_list_cubit.dart';
import 'package:dallal_proj/features/sections_page/presentation/manager/fetch_house_list_cubit/fetch_house_list_cubit.dart';
import 'package:dallal_proj/features/sections_page/presentation/manager/fetch_land_list_cubit/fetch_land_list_cubit.dart';
import 'package:dallal_proj/features/sections_page/presentation/manager/fetch_shop_list_cubit/fetch_shop_list_cubit.dart';
import 'package:dallal_proj/temp_try.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SectionsBody extends StatelessWidget {
  const SectionsBody({
    super.key,
    required this.topLCell,
    required this.topRCell,
    required this.btmLCell,
    required this.btmRCell,
  });
  final SectCardModel topLCell, topRCell, btmLCell, btmRCell;
  @override
  Widget build(BuildContext context) {
    return BodyCellCards(
      topLeft: HousesSectionCardBuilder(topLCell: topLCell),
      topRight: AptsSectionCardBuilder(topRCell: topRCell),
      bottomLeft: ShopsSectionCardBuilder(btmLCell: btmLCell),
      bottomRight: LandsSectionCardBuilder(btmRCell: btmRCell),
    );
  }
}

class LandsSectionCardBuilder extends StatelessWidget {
  const LandsSectionCardBuilder({super.key, required this.btmRCell});

  final SectCardModel btmRCell;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchLandListCubit, FetchLandListState>(
      builder: (context, state) {
        if (state is FetchLandListSuccess) {
          return SectCellCard(
            advCount: state.landList.advCount ?? '00',
            name: btmRCell.name,
            img: btmRCell.img,
            onTap:
                () => GoRouter.of(
                  context,
                ).pushNamed(btmRCell.routePath, extra: state.landList),
          );
        }
        if (state is FetchLandListFailure) {
          return SectCellCard(
            advCountSuffix: 'الإعلانات',
            advCount: 'خطأ اثناء جلب',
            name: btmRCell.name,
            img: btmRCell.img,
            onTap: () {},
          );
        }
        return SectCellCard(
          advCountSuffix: '...',
          advCount: 'جاري جلب الإعلانات',
          name: btmRCell.name,
          img: btmRCell.img,
          onTap: () {},
        );
      },
    );
  }
}

class ShopsSectionCardBuilder extends StatelessWidget {
  const ShopsSectionCardBuilder({super.key, required this.btmLCell});

  final SectCardModel btmLCell;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchShopListCubit, FetchShopListState>(
      builder: (context, state) {
        if (state is FetchShopListSuccess) {
          return SectCellCard(
            advCount: state.shopList.advCount ?? '00',
            name: btmLCell.name,
            img: btmLCell.img,
            onTap:
                () => GoRouter.of(
                  context,
                ).pushNamed(btmLCell.routePath, extra: state.shopList),
          );
        }
        if (state is FetchShopListFailure) {
          return SectCellCard(
            advCountSuffix: 'الإعلانات',
            advCount: 'خطأ اثناء جلب',
            name: btmLCell.name,
            img: btmLCell.img,
            onTap: () {},
          );
        }
        return SectCellCard(
          advCountSuffix: '...',
          advCount: 'جاري تحميل الإعلانات',
          name: btmLCell.name,
          img: btmLCell.img,
          onTap: () {},
        );
      },
    );
  }
}

class AptsSectionCardBuilder extends StatelessWidget {
  const AptsSectionCardBuilder({super.key, required this.topRCell});

  final SectCardModel topRCell;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchAptListCubit, FetchAptListState>(
      builder: (context, state) {
        if (state is FetchAptListSuccess) {
          return SectCellCard(
            advCount: state.aptList.advCount ?? '00',
            name: topRCell.name,
            img: topRCell.img,
            onTap:
                () => GoRouter.of(
                  context,
                ).pushNamed(topRCell.routePath, extra: state.aptList),
          );
        }
        if (state is FetchAptListFailure) {
          return SectCellCard(
            advCountSuffix: 'الإعلانات',
            advCount: 'خطأ اثناء جلب',
            name: topRCell.name,
            img: topRCell.img,
            onTap: () {},
          );
        }
        return SectCellCard(
          advCountSuffix: '...',
          advCount: 'جاري جلب الإعلانات',
          name: topRCell.name,
          img: topRCell.img,
          onTap: () {},
        );
      },
    );
  }
}

class HousesSectionCardBuilder extends StatelessWidget {
  const HousesSectionCardBuilder({super.key, required this.topLCell});

  final SectCardModel topLCell;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FetchHouseListCubit, FetchHouseListState>(
      builder: (context, state) {
        if (state is FetchHouseListSuccess) {
          return SectCellCard(
            advCount: state.houseList.advCount ?? '0',
            name: topLCell.name,
            img: topLCell.img,
            onTap:
                () => GoRouter.of(
                  context,
                ).pushNamed(topLCell.routePath, extra: state.houseList),
          );
        }
        if (state is FetchHouseListFailure) {
          return SectCellCard(
            advCountSuffix: 'الإعلانات',
            advCount: 'خطأ اثناء جلب',
            name: topLCell.name,
            img: topLCell.img,
            onTap: () {},
          );
        }
        return SectCellCard(
          advCountSuffix: '...',
          advCount: 'جاري جلب الإعلانات',
          name: topLCell.name,
          img: topLCell.img,
          onTap: () {},
        );
      },
    );
  }
}
