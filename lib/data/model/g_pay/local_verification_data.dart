class LocalVerificationResponseModel {
  String? orderId;
  String? packageName;
  String? productId;
  String? purchaseTime;
  String? purchaseState;
  String? purchaseToken;
  String? quantity;
  String? acknowledged;

  LocalVerificationResponseModel({
    this.orderId,
    this.packageName,
    this.productId,
    this.purchaseTime,
    this.purchaseState,
    this.purchaseToken,
    this.quantity,
    this.acknowledged,
  });

  factory LocalVerificationResponseModel.fromJson(Map<String, dynamic> json) => LocalVerificationResponseModel(
        orderId: json["orderId"],
        packageName: json["packageName"],
        productId: json["productId"],
        purchaseTime: json["purchaseTime"].toString(),
        purchaseState: json["purchaseState"].toString(),
        purchaseToken: json["purchaseToken"],
        quantity: json["quantity"].toString(),
        acknowledged: json["acknowledged"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "packageName": packageName,
        "productId": productId,
        "purchaseTime": purchaseTime,
        "purchaseState": purchaseState,
        "purchaseToken": purchaseToken,
        "quantity": quantity,
        "acknowledged": acknowledged,
      };
}
