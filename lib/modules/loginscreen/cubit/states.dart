abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {}

class GetUserDataLoadingState extends LoginState{}

class GetUserDataSuccessState extends LoginState{}

class GetUserDataErrorState extends LoginState{}

class UpdateUserLoadingState extends LoginState{}

class UpdateUserSuccessState extends LoginState{}

class UpdateUserErrorState extends LoginState{}