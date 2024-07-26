import 'package:bloc/bloc.dart';
import 'package:fixit_provider/features/authentication/data/datasources/service_provider_repository.dart';
import 'package:meta/meta.dart';

part 'user_status_event.dart';
part 'user_status_state.dart';

class UserStatusBloc extends Bloc<UserStatusEvent, UserStatusState> {
  UserStatusBloc() : super(UserStatusInitial()) {
    ServiceProviderRepository providerRepo = ServiceProviderRepository();
    on<UserStatusEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<CheckUserStatus>((event, emit) async {
      print('printing from userstatus bloc');
      emit(UserStatusChecking());
      try {
        final bool isVerified =
            await providerRepo.isServiceProviderVerifed(event.userId);
        print('isVErified : $isVerified');
        if (isVerified == true) {
          emit(UserVerified());
        } else {
          emit(UserNotVerified());
        }
      } catch (e) {
        emit(UserStatusFailure());
      }
    });
  }
}
