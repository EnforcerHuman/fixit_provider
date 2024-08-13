import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayPaymentService {
  final Razorpay _razorpay = Razorpay();

  Future<void> initPayment({
    required Function(PaymentSuccessResponse) onSuccess,
    required Function(PaymentFailureResponse) onError,
    required Function(ExternalWalletResponse) onWalletSelected,
  }) async {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, onError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, onWalletSelected);

    var options = {
      'key': 'rzp_test_0m2EoTRDBZFgXp',
      'amount': 100,
      'name': 'Your Company Name',
      'description': 'Payment to provider',
      'prefill': {'contact': '6282431089', 'email': 'melbin@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  void dispose() {
    _razorpay.clear();
  }
}
