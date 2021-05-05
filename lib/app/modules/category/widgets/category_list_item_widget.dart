import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:itcase/app/modules/category/controllers/category_controller.dart';

import '../../../../common/ui.dart';
import '../../../models/category_model.dart';
import '../../../routes/app_pages.dart';

class CategoryListItemWidget extends StatelessWidget {
  final Category category;
  final String heroTag;

  CategoryListItemWidget({Key key, this.category, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        print(category.title);
        // print(Get.find<CategoryController>());
        Get.toNamed(Routes.CATEGORY, arguments: category);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: Ui.getBoxDecoration(
            gradient: new LinearGradient(
                colors: [ category.backGround.withOpacity(1),
                  category.backGround.withOpacity(0.2)],
                begin: AlignmentDirectional.topStart, //const FractionalOffset(1, 0),
                end: AlignmentDirectional.topEnd,
                stops: [0.0, 0.5],
                tileMode: TileMode.clamp)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 60,
              height: 60,
              child: (category.image.toLowerCase().endsWith('.svg')
                  ? SvgPicture.network(
                category.image,
                color: category.color,
                height: 100,
              )
                  : CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: category.image,
                placeholder: (context, url) => Image.asset(
                  'assets/img/loading.gif',
                  fit: BoxFit.cover,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error_outline),
              )),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                category.title,
                overflow: TextOverflow.fade,
                softWrap: false,
                style: Get.textTheme.bodyText2.merge(TextStyle(color: Get.theme.primaryColor)),
              ),
            ),

          ],
        ),
      ),
    );
  }
}