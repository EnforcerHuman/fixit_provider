enum PaymentStatus { success, error, walletSelected }

class PaymentResult {
  final PaymentStatus status;
  final String? message;

  PaymentResult({required this.status, this.message});
}
