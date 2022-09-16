import 'package:rc_china_freshplan_app/data/address.dart';

class Payment {
  String? payWayCode;
  String? payWayOrderID;
  String? amount;
  String? paymentStartTime;
  String? paymentFinishTime;
  String? lastModifiedBy;
  String? paymentState;
}

class OrderPrice {
  double? productPrice;
  double? deliveryPrice;
  double? totalPrice;
  double? discountsPrice;
  double? vipDiscountsPrice;
}

class OrderState {
  String? orderType;
  String? orderState;
  String? storeId;
  String? lastModifiedAt;
  String? lastModifiedBy;
  String? createdAt;
  String? createdBy;
  String? orderSource;
}

class OrderProductAttributeAndValue {
  String? attributeName;
  String? attributeNameEn;
  String? attributeValueName;
  String? attributeValueNameEn;
  String? relId;
  String? attributeId;
  String? attributeValueId;
  String? productId;
}

class OrderLineItem {
  String? id;
  String? skuNo;
  String? spuNo;
  String? skuName;
  String? spuName;
  String? productSpecifications;
  String? pic;
  String? price;
  String? num;
  List<OrderProductAttributeAndValue>? productAttributeAndValues;
  double? feedingDays;
  bool? isGift;
}

class Logs {
  String? id;
  String? status;
  String? createdAt;
  String? createdBy;
}

class Invoice {
  String? status;
}

class Buyer {
  bool? isMember;
  String? consumerId;
  String? consumerName;
  String? consumerEmail;
  String? consumerLevel;
  String? nickName;
  String? phone;
}

class DeliveryInfo {
  String? time;
  String? context;
  String? areaCode;
  String? areaName;
  String? status;
}

class ShippingInfo {
  String? shippingTime;
  String? expectedShippingDate;
  String? shippingCompany;
  String? shippingCompanyImg;
  String? trackingId;
  String? isReturn;
  String? status;
  DeliveryInfo? deliveryItems;
}

class Order {
  String? id;
  String? orderNumber;
  String? version;
  List<OrderLineItem>? lineItem;
  AddRess? shippingAddress;
  Payment? payment;
  String? isSubscription;
  String? subscriptionId;
  String? freshType;
  String? subscriptionNo;
  OrderPrice? orderPrice;
  OrderState? orderState;
  Invoice? invoice;
  Logs? logs;
  String? remark;
  Buyer? buyer;
  ShippingInfo? delivery;

  Order(
      {this.id,
      this.orderNumber,
      this.version,
      this.lineItem,
      this.shippingAddress,
      this.payment,
      this.isSubscription,
      this.subscriptionId,
      this.freshType,
      this.subscriptionNo,
      this.orderPrice,
      this.orderState,
      this.invoice,
      this.remark,
      this.buyer,
      this.delivery,
      this.logs});
}
