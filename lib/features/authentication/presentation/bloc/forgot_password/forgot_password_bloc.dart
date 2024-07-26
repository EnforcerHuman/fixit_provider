import 'package:bloc/bloc.dart';
import 'package:fixit_provider/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:meta/meta.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthRemoteDataSource authRemoteDataSource;
  ForgotPasswordBloc(this.authRemoteDataSource)
      : super(ForgotPasswordInitial()) {
    on<ForgotPasswordEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SentResetLink>((event, emit) async {
      emit(ResetLinkSending());
      try {
        authRemoteDataSource.sendPasswordResetEmail(event.email);
        await Future.delayed(Duration(seconds: 4));
        emit(ResetLinkSent());
      } catch (e) {
        emit(ResetLinkSentFailed(e.toString()));
      }
    });
  }
}
