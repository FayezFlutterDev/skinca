import '../../../core/models/banner_model.dart';

class HomeState {}

class HomeInitial extends HomeState {}

class BannersLoading extends HomeState {}

class BannersSuccess extends HomeState {
  final List<BannerModel> banners;

  BannersSuccess(this.banners);
}

class BannersFailure extends HomeState {
  final String error;

  BannersFailure(this.error);
}
