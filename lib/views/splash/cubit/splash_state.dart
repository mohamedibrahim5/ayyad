part of 'splash_cubit.dart';

sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class OrganizationLoadingState extends SplashState {}
final class OrganizationSuccess extends SplashState {}
final class OrganizationErrorState extends SplashState {}


