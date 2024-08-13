import 'package:firebase_core/firebase_core.dart';
import 'package:fixit_provider/features/authentication/data/datasources/auth_remote_data_source.dart';
import 'package:fixit_provider/features/authentication/data/datasources/firebase_storage_services.dart';
import 'package:fixit_provider/features/authentication/data/datasources/get_location.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/location/location_bloc.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/service_provider/service_provider_bloc.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/sign_in/sign_in_bloc.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/upload_file/upload_file_bloc.dart';
import 'package:fixit_provider/features/authentication/presentation/bloc/user_status/user_status_bloc.dart';
import 'package:fixit_provider/features/booking/domain/usecases/booking_use_case.dart';
import 'package:fixit_provider/features/booking/domain/usecases/update_booking_status_usecases.dart';
import 'package:fixit_provider/features/booking/presentation/bloc/cancelled_bookings.dart/cancelled_bookings_bloc.dart';
import 'package:fixit_provider/features/booking/presentation/bloc/completed_bookings_bloc/completed_bookings_bloc.dart';
import 'package:fixit_provider/features/booking/presentation/bloc/payment_request_bloc/payment_request_bloc.dart';
import 'package:fixit_provider/features/booking/presentation/bloc/request_status_bloc/request_status_bloc.dart';
import 'package:fixit_provider/features/booking/presentation/bloc/requested_bookings_bloc/requested_bookings_bloc.dart';
import 'package:fixit_provider/features/booking/presentation/bloc/upcoming_bookings_bloc/upcoming_bookings_bloc.dart';
import 'package:fixit_provider/features/payment/domain/repositories/payment_repositories.dart';
import 'package:fixit_provider/features/payment/presentation/bloc/payment_bloc/payment_bloc.dart';
import 'package:fixit_provider/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBIL2QGPyrbqyCXF9sCP_m0lrhvr6gK2oM",
          appId: "1:697886710494:android:773bddd5f8e39041c3004f",
          messagingSenderId: "697886710494",
          projectId: "fixit-1b8b8",
          storageBucket: "fixit-1b8b8.appspot.com"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignUpBloc(),
        ),
        BlocProvider(create: (context) => ServiceProviderBloc()),
        BlocProvider(
            create: (context) =>
                LocationBloc(getCurrentLocation: GetCurrentLocation())),
        BlocProvider(
            create: (context) => UploadFileBloc(FirebaseStorageService())),
        BlocProvider(create: (context) => SignInBloc()),
        BlocProvider(create: (context) => UserStatusBloc()),
        BlocProvider(
            create: (context) => ForgotPasswordBloc(AuthRemoteDataSource())),
        BlocProvider(
            create: (context) => RequestedBookingsBloc(BookingUseCase())),
        BlocProvider(
            create: (context) => UpcomingBookingsBloc(BookingUseCase())),
        BlocProvider(
            create: (context) => CancelledBookingsBloc(BookingUseCase())),
        BlocProvider(
            create: (context) => CompletedBookingsBloc(BookingUseCase())),
        BlocProvider(
            create: (context) =>
                RequestStatusBloc(UpdateBookingStatusUsecases())),
        BlocProvider(
            create: (context) =>
                PaymentRequestBloc(UpdateBookingStatusUsecases()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
