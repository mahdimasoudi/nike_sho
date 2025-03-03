import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_shop/data/common/utils.dart';
import 'package:nike_shop/data/model/product.dart';
import 'package:nike_shop/screen/product/comment/comment_list.dart';
import 'package:nike_shop/screen/theme.dart';
import 'package:nike_shop/screen/widgets/image.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          width: MediaQuery.of(context).size.width - 48,
          child: FloatingActionButton.extended(
            onPressed: () {},
            label: const Text('افزودن به سبد خرید'),
          ),
        ),
     //در فریمورک Flutter، اگر بخواهید یک لیست اسکرولی با ساختاری منعطف داشته باشید، به جای ListView می‌توانید از CustomScrollView استفاده کنید. این ویجت به شما امکان می‌دهد که از slivers برای کنترل دقیق‌تر اسکرول استفاده کنید.
     
        body: CustomScrollView(
          physics: defaultScrollPhysics,
//Sliver در واقع یک بخش (جزء) اسکرولی است که می‌توان آن را داخل CustomScrollView قرار داد. برخی از رایج‌ترین sliverها:
//✔️ SliverAppBar → نوار بالایی که هنگام اسکرول مخفی یا کوچک می‌شود.
//✔️ SliverList → لیستی که مانند ListView کار می‌کند اما انعطاف‌پذیرتر است.
//✔️ SliverGrid → مانند GridView اما درون CustomScrollView قابل استفاده است.
//✔️ SliverToBoxAdapter → برای نمایش یک ویجت معمولی درون Sliverها.
//چرا از CustomScrollView و Slivers استفاده کنیم؟
//✔️ کنترل دقیق‌تر روی اسکرول و انیمیشن‌ها
//✔️ ترکیب چندین نوع لیست یا ویجت در یک صفحه
//✔️ بهینه‌تر از ListView برای برخی سناریوها
//✔️ امکان ایجاد افکت‌های جذاب هنگام اسکرول، مانند AppBar کشویی
          slivers: [

            SliverAppBar(
              //MediaQuery \/
              //برای دریافت عرض صفحه گوشی
              expandedHeight: MediaQuery.of(context).size.width * 0.8,//طول عکس 0.8 عرض صفحه
              //طراحی که میتواند در بالای صفحه قرار بگیرد
              flexibleSpace: ImageLoadingService(imageUrl: product.imageUrl),
              foregroundColor: LightThemeColors.primaryTextColor,
              actions: [
                IconButton(
                    onPressed: () {}, icon: const Icon(CupertinoIcons.heart))
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          product.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              product.previousPrice.withPriceLabel,
                              style: Theme.of(context).textTheme.bodySmall!.apply(
                                  decoration: TextDecoration.lineThrough),
                            ),
                            Text(product.price.withPriceLabel),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      'این کتونی شدیدا برای دویدن و راه رفتن مناسب هست و تقریبا. هیچ فشار مخربی رو نمیذارد به پا و زانوان شما انتقال داده شود',
                      style: TextStyle(height: 1.4),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'نظرات کاربران',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        TextButton(onPressed: () {}, child: const Text('ثبت نظر'))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            CommentList(productId: product.id),
          ],
        ),
      ),
    );
  }
}
