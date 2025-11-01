part of 'package_cubit.dart';

abstract class PackageState {}

class PackageInitial extends PackageState {}

class PackageLoading extends PackageState {}

class PackageSuccess extends PackageState {
  final List<DeliveryModel> packages;
  PackageSuccess(this.packages);
}

class PackageError extends PackageState {
  final String message;
  PackageError(this.message);
}
