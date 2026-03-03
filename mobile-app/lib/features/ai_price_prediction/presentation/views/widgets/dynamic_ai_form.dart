import 'package:dallal_proj/core/components/app_bottom_sheets/a_i_b_s/ai_bs_form_title/ai_bs_form_title.dart';
import 'package:dallal_proj/core/components/app_btns/col_btn.dart';
import 'package:dallal_proj/core/components/app_btns/models/x_b_size.dart';
import 'package:dallal_proj/core/constants/app_texts.dart';
import 'package:dallal_proj/core/theme/app_colors.dart';
import 'package:dallal_proj/core/theme/app_font_styles.dart';
import 'package:dallal_proj/core/theme/app_themes.dart';
import 'package:dallal_proj/core/utils/app_funcs.dart';
import 'package:dallal_proj/core/widgets/helpers/widgets_helper.dart';
import 'package:dallal_proj/core/widgets/symmetric_pads/v_p_item.dart';
import 'package:dallal_proj/core/widgets/two_item_widgets/two_itm_col.dart';
import 'package:dallal_proj/features/ai_price_prediction/data/repos/ai_prediction_repo_impl.dart';
import 'package:dallal_proj/features/ai_price_prediction/presentation/manager/ai_prediction_cubit.dart';
import 'package:dallal_proj/core/utils/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Dynamic AI Form that connects to the local AI model for price prediction.
///
/// This form takes the property details and displays the AI-predicted price
/// with currency conversion support.
class DynamicAIForm extends StatelessWidget {
  const DynamicAIForm({
    super.key,
    required this.city,
    required this.areaName,
    required this.propertyType,
    required this.dealType,
    required this.areaM2,
    required this.rooms,
    required this.baths,
    required this.floors,
    required this.currency,
  });

  /// City name (e.g., "Sanaa", "sanaa")
  final String city;

  /// Area/neighborhood name
  final String areaName;

  /// Property type in English (e.g., "apartment", "house", "land", "shop")
  final String propertyType;

  /// Deal type (e.g., "rent", "sale_freehold", "sale_waqf")
  final String dealType;

  /// Area in square meters
  final int areaM2;

  /// Number of rooms
  final int rooms;

  /// Number of bathrooms
  final int baths;

  /// Number of floors
  final int floors;

  /// Currency for price display ("YER", "USD", "SAR")
  final String currency;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              AiPredictionCubit(repo: getIt.get<AiPredictionRepoImpl>())
                ..predictPrice(
                  city: city,
                  areaName: areaName,
                  propertyType: propertyType,
                  dealType: dealType,
                  areaM2: areaM2,
                  rooms: rooms,
                  baths: baths,
                  floors: floors,
                  currency: currency,
                ),
      child: const _DynamicAIFormContent(),
    );
  }
}

class _DynamicAIFormContent extends StatelessWidget {
  const _DynamicAIFormContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiPredictionCubit, AiPredictionState>(
      builder: (context, state) {
        return Column(
          children: [
            const AiBsFormTitle(),
            VPItem(
              bSpc: 30,
              child: TwoItmCol(
                topChild: _buildPriceContent(context, state),
                btmChild: WidH.respSep(context),
              ),
            ),
            _buildReasonContent(state),
            _buildCloseButton(context, state),
          ],
        );
      },
    );
  }

  Widget _buildPriceContent(BuildContext context, AiPredictionState state) {
    return VPItem(
      tSpc: 20,
      bSpc: 20,
      child: Container(
        height: 136,
        width: Funcs.frwGetter(368, context),
        padding: const EdgeInsets.only(right: 16, bottom: 20, left: 36),
        decoration: Themer.aiBtn(kPredictedPriceItemColors, 32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                kPredictedPrice,
                style: FStyles.s14w6.copyWith(color: kWhite),
                textDirection: WidH.trd,
              ),
              const SizedBox(height: 8),
              _buildPriceDisplay(state),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceDisplay(AiPredictionState state) {
    if (state is AiPredictionLoading) {
      return const SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(color: kWhite, strokeWidth: 2),
      );
    } else if (state is AiPredictionSuccess) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          state.formattedPrice,
          style: FStyles.s14w6.copyWith(color: kPrimColG),
          textDirection: WidH.trd,
        ),
      );
    } else if (state is AiPredictionFailure) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: kWhite.withAlpha(230),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          'خطأ في الاتصال',
          style: FStyles.s12w5.copyWith(color: Colors.red),
          textDirection: WidH.trd,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildReasonContent(AiPredictionState state) {
    String reasonText = '';

    if (state is AiPredictionSuccess) {
      reasonText = state.message;
    } else if (state is AiPredictionFailure) {
      reasonText = state.errorMessage;
    } else if (state is AiPredictionLoading) {
      reasonText = 'جارٍ تحليل البيانات...';
    }

    if (reasonText.isEmpty) {
      return const SizedBox.shrink();
    }

    return VPItem(
      bSpc: 40,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text.rich(
          textDirection: WidH.trd,
          textAlign: WidH.tra,
          TextSpan(
            children: [
              TextSpan(
                text: state is AiPredictionFailure ? 'الخطأ:\n\n' : kReason,
                style: FStyles.s17w5.copyWith(
                  color: state is AiPredictionFailure ? Colors.red : null,
                ),
              ),
              TextSpan(
                text: reasonText,
                style: FStyles.s17w4.copyWith(
                  color:
                      state is AiPredictionFailure ? Colors.red.shade700 : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context, AiPredictionState state) {
    final bool isLoading = state is AiPredictionLoading;

    return VPItem(
      tSpc: 40,
      bSpc: 26,
      child: Column(
        children: [
          if (state is AiPredictionFailure)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ColBtn(
                txt: 'إعادة المحاولة',
                size: const XBSize(),
                deco: Themer.aiBtn([Colors.orange, Colors.deepOrange], 8),
                onPressed:
                    isLoading
                        ? null
                        : () {
                          // Retry the prediction using the cubit's retry method
                          context.read<AiPredictionCubit>().retry();
                        },
              ),
            ),
          ColBtn(
            txt: kClose,
            size: const XBSize(),
            deco: Themer.aiBtn(kPredictedPriceItemColors, 8),
            onPressed: isLoading ? null : () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
