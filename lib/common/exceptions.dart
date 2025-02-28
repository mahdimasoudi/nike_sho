class AppException {
  final String message;
//فایل هایی که مشترک در ماژول های مختلف استفاده میشود در Common قرار میگیرد
  AppException({this.message = 'خطای نامشخص'});
}
