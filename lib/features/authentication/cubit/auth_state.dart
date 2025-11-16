import 'package:flutter/material.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class SignUpLoading extends AuthState {}

class SignUpSuccess extends AuthState {}

class SignUpError extends AuthState {
  final String message;
  SignUpError(this.message);
}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginError extends AuthState {
  final String message;
  LoginError(this.message);
}
