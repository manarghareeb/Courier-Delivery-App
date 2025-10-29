
abstract class AccountState{
  const AccountState();
}

class AccountInitial extends AccountState {}

class AccountLogoutLoading extends AccountState {}
class AccountLogoutSuccess extends AccountState {}
class AccountLogoutError extends AccountState {
  final String message;
  AccountLogoutError(this.message);
}

class AccountUpdateLoading extends AccountState {}
class AccountUpdateSuccess extends AccountState {}
class AccountUpdateError extends AccountState {
  final String message;
  AccountUpdateError(this.message);
}
/*class AccountLoading extends AccountState {}
class AccountSuccess extends AccountState {
  final UserModel user;
  const AccountSuccess(this.user);
}
class AccountUpdated extends AccountState {
  final UserModel updatedUser;
  const AccountUpdated(this.updatedUser);
}
class AccountDeleted extends AccountState {}
class AccountLoggedOut extends AccountState {}
class AccountError extends AccountState {
  final String message;
  const AccountError(this.message);
}*/
