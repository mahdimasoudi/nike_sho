part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final AppException exception;
  const HomeError({required this.exception});

  @override
  //اگر این Exception با exception بعدی یکی باشد دیگر باعث rebuild شدن نمیشود.
  // یکی از خواص Equatable میباشد
  //به صورت پیش فرض هر زمان  Errore به وجود بیاد باعث rebuild شدن صفحه Home میشود.
  List<Object> get props => [exception];
}

class HomeSuccess extends HomeState {
  final List<BannerEntity> banners;
  final List<ProductEntity> latestProducts;
  final List<ProductEntity> popularProducts;

  const HomeSuccess(
      {required this.banners,
      required this.latestProducts,
      required this.popularProducts});
}
