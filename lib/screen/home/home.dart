import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_shop/data/common/utils.dart';
import 'package:nike_shop/data/model/product.dart';
import 'package:nike_shop/data/repo/banner_repository.dart';
import 'package:nike_shop/data/repo/product_repository.dart';
import 'package:nike_shop/screen/home/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shop/screen/product/product.dart';
import 'package:nike_shop/screen/widgets/image.dart';
import 'package:nike_shop/screen/widgets/slider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homeBloc = HomeBloc(
            bannerRepository: bannerRepository,
            productRepository: productRepository);
        // event homestarter را صدا میزند
        //کلا add همون داستان steream ها هستش.
        homeBloc.add(HomeStarted());
        return homeBloc;
      },
      child: Scaffold(
        // از SafeArea استفاده مکنیم برای این که ما در این برنامه از AppBar استفاده نمیکنیم و قسمتی از UI میرود زیر نوار بالای صفحه.
        body: SafeArea(
          // این BlocBuilder مربوط به homeBloc هستش HomeState به ما میده و
          //هزمان که state مربوط به این صفحه تغییر کند body این safeArea rebuild میشود .
          child: BlocBuilder<HomeBloc, HomeState>(builder: ((context, state) {
            if (state is HomeSuccess) {
              //در این جا برای نمایش جزییات صفحه میشد از Coulm استفاده کرد .
              // ولی چون با scroll کردن جزئیات پایین صفحه load میشود ، بهتر است در صفحه هایی که جزئیات زیادی دارد از ListView استفادخ کرد.
              return ListView.builder(
                  itemCount: 5,
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 100),
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 0:
                        return Image.asset(
                          'lib/assets/images/Digikala.png',
                          height: 80,
                        );
                      case 2:
                        return BannerSlider(
                          banners: state.banners,
                        );
                      case 3:
                        return _HorizontalProductList(
                          title: 'جدیدترین',
                          onTap: () {},
                          products: state.latestProducts,
                        );
                      case 4:
                        return _HorizontalProductList(
                          title: 'پربازدیدترین',
                          onTap: () {},
                          products: state.popularProducts,
                        );
                      default:
                        return Container();
                    }
                  });
            } else if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(state.exception.message),
                    ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
                        },
                        child: const Text('تلاش دوباره')),
                  ],
                ),
              );
            } else {
              throw Exception('state is not supported');
            }
          })),
        ),
      ),
    );
  }
}

class _HorizontalProductList extends StatelessWidget {
  final String title;
  final GestureTapCallback onTap;
  final List<ProductEntity> products;
  const _HorizontalProductList({
    required this.title,
    required this.onTap,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              TextButton(onPressed: onTap, child: const Text('مشاهده همه'))
            ],
          ),
        ),
        SizedBox(
          height: 300,
          child: ListView.builder(
              physics: defaultScrollPhysics,
              itemCount: products.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 8, right: 8),
              itemBuilder: ((context, index) {
                final product = products[index];
                return ProductItem(
                  product: product,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                );
              })),
        )
      ],
    );
  }
}

