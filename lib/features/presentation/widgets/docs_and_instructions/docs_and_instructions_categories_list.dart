import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nevis/constants/paths.dart';
import 'package:nevis/constants/ui_constants.dart';
import 'package:nevis/core/links/external_links.dart';
import 'package:nevis/core/routes.dart';
import 'package:nevis/features/presentation/pages/profile/privacy_policy_screen.dart';
import 'package:nevis/features/presentation/widgets/category_screen/subcategory_item.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

class DocsAndInstructionsCategoriesList extends StatelessWidget {
  const DocsAndInstructionsCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeleton.ignorePointer(
      child: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          SubcategoryItem(
              title: 'Пользовательское соглашение',
              titleStyle: UiConstants.textStyle3,
              imagePath: Paths.documnetsAndInstructionsIconPath,
              onTap: () => _launchUrl(ExternalLinks.userAgreement)),
          SizedBox(height: 8.h),
          SubcategoryItem(
            title: 'Правила бронирования\nи доставки',
            titleStyle: UiConstants.textStyle3,
            imagePath: Paths.boookingIconPath,
            onTap: () => Navigator.of(context).push(
              Routes.createRoute(
                const PrivacyPolicyScreen(),
                settings: RouteSettings(name: Routes.privacyPolicyScreen),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          SubcategoryItem(
            title: 'Политика обработки\nперсональных данных',
            titleStyle: UiConstants.textStyle3,
            imagePath: Paths.privacyPolicyIconPath,
            onTap: () => _launchUrl(ExternalLinks.privacyPolicyUrl),
          ),
          SizedBox(height: 8.h),
          SubcategoryItem(
              title: 'Интсрукция по оформлению\nзаказа',
              titleStyle: UiConstants.textStyle3,
              imagePath: Paths.instructionIconPath,
              onTap: () => _launchUrl(ExternalLinks.bookingRulesUrl)),
          SizedBox(height: 8.h),
          SubcategoryItem(
              title: 'Правила бонусной программы «Ваша карта CASHBACK»',
              titleStyle: UiConstants.textStyle3,
              imagePath: Paths.bonusIconPath,
              onTap: () => _launchUrl(ExternalLinks.bonusProgrammUrl)),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String link) async {
    final Uri _url = Uri.parse(link);
    await launchUrl(_url);
  }
}
