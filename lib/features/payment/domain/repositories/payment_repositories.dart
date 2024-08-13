import 'package:fixit_provider/features/payment/domain/enitities/payment_result.dart';

abstract class PaymentRepository {
  Future<PaymentResult> initiatePayment();
}
