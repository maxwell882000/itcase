import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../../common/ui.dart';

import '../../../models/category_model.dart';

class CategoryGridItemWidget extends StatelessWidget {
  final Category category;
  final String heroTag;

  CategoryGridItemWidget({Key key, this.category, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        Get.toNamed(Routes.CATEGORY, arguments: category);
        //Navigator.of(context).pushNamed('/Details', arguments: RouteArgument(id: '0', param: market.id, heroTag: heroTag));
      },
      child: Container(
        decoration: Ui.getBoxDecoration(),
        child: Wrap(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [category.color.withOpacity(1), category.color.withOpacity(0.1)],
                    begin: AlignmentDirectional.topStart, //const FractionalOffset(1, 0),
                    end: AlignmentDirectional.bottomEnd,
                    stops: [0.1, 0.9],
                    tileMode: TileMode.clamp),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              ),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    category.title ?? '',
                    style: Theme.of(context).textTheme.bodyText2,
                    softWrap: false,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  // SizedBox(height: 2),
                  // Row(
                  //   children: Helper.getStarsList(double.parse(market.rate)),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
