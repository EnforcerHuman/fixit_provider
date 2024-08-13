import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayService {
  late Razorpay _razorpay;

  RazorpayService() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle the success response
    print("Payment Success: ${response.paymentId}");
    // You can also show a UI alert or navigate to another screen here
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle the error response
    print("Payment Error: ${response.code} - ${response.message}");
    // You can also show an error message or retry option here
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle the external wallet response
    print("External Wallet: ${response.walletName}");
    // You can also show a UI alert here
  }

  void openCheckout() {
    var options = {
      'key': 'rzp_test_0m2EoTRDBZFgXp', // Replace with your Razorpay Key
      'amount': 10000, // Amount in paise (100 paise = 1 INR)
      'name': 'Fixit',
      'description': 'Payment for testing',
      'prefill': {'contact': '8888888888', 'email': 'test@example.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }
}

class PaymentScreen extends StatelessWidget {
  final RazorpayService _razorpayService = RazorpayService();

  PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Razorpay Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _razorpayService.openCheckout();
          },
          child: Text('Pay with Razorpay'),
        ),
      ),
    );
  }
}
