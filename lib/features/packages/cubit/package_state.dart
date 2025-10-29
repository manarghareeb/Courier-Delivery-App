part of 'package_cubit.dart';

abstract class PackageState {}

class PackageInitial extends PackageState {}

class PackageLoading extends PackageState {}

class PackageSuccess extends PackageState {
  final List<Map<String, dynamic>> pending;
  final List<Map<String, dynamic>> inTransit;
  final List<Map<String, dynamic>> delivered;

  PackageSuccess({
    required this.pending,
    required this.inTransit,
    required this.delivered,
  });
}

class PackageError extends PackageState {
  final String message;
  PackageError(this.message);
}
