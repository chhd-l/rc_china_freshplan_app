const String orderListQuery = r'''
    query orderFindPage($input: OrderPageInput!){
      orderFindPage(input: $input) {
      offset
      limit
      total
      records {
        _id
        orderNumber
        version
        subscriptionId
        subscriptionNo
        freshType
        lineItem {
          isGift
          id
          skuNo
          spuNo
          skuName
          spuName
          productSpecifications
          pic
          price
          num
          productAttributeAndValues{
            attributeName
            attributeNameEn
            attributeValueName
            attributeValueNameEn
            relId
            attributeId
            attributeValueId
            productId
            }
            feedingDays
        }
        payment{
          paymentId
          amount
          paymentStartTime
          paymentFinishTime
          payWayCode
          payWayOrderId
          paymentState
        }

        isSubscription
        orderPrice {
          productPrice
          totalPrice
          deliveryPrice
          discountsPrice
          vipDiscountsPrice
        }
        orderState {
          orderType
          orderState
          storeId
          lastModifiedAt
          lastModifiedBy
          createdAt
          createdBy
          orderSource
        }
        shippingAddress{
          id
          consumerId
          receiverName
          phone
          country
          province
          city
          region
          detail
          postcode
          isDefault
        }
        delivery{
          shippingTime
          expectedShippingDate
          shippingCompany
          shippingCompanyImg
          trackingId
          isReturn
          status
          deliveryItems{
            time
            context
            areaCode
            areaName
            status
          }
        }
        logs{
          id
          status
          createdAt
          createdBy
        }
        remark
        consumer {
          isMember
          consumerId
          consumerName
          consumerEmail
          consumerLevel
          nickName
          phone
          avatarUrl
          unionId
          openId
        }
        invoice {
          invoiceId
          status
          type
          addTime
          updateTime
          auditTime
          printTime
          no
          purchaserName
          purchaserTaxpayerNumber
          purchaserAddress
          purchaserPhone
          purchaserBank
          purchaserBankAccount
          mobile
          email
        }
      }
    }
  }
''';

const String orderDetailQuery = r'''
  query orderGet($input:OrderGetInput){
    orderGet(input:$input) {
       _id
      orderNumber
      version
      isSubscription
      subscriptionId
      subscriptionNo
      freshType
      lineItem {
        id
        isGift
        skuNo
        spuNo
        skuName
        spuName
        productSpecifications
        pic
        price
        num
         productAttributeAndValues{
          attributeName
          attributeNameEn
          attributeValueName
          attributeValueNameEn
          relId
          attributeId
          attributeValueId
          productId
          }
          feedingDays
      }
      shippingAddress{
        id
        consumerId
        receiverName
        phone
        country
        province
        city
        region
        detail
        postcode
        isDefault
      }
      delivery{
        shippingTime
        expectedShippingDate
        shippingCompany
        shippingCompanyImg
        trackingId
        isReturn
        status
        deliveryItems{
          time
          context
          areaCode
          areaName
          status
        }
      }
      payment{
       paymentId
         amount
         paymentStartTime
         paymentFinishTime
         payWayCode
         payWayOrderId
         paymentState
      }
      orderPrice {
        productPrice
        totalPrice
        deliveryPrice
        discountsPrice
        vipDiscountsPrice
      }
      orderState {
        orderType
        orderState
        storeId
        lastModifiedAt
        lastModifiedBy
        createdAt
        createdBy
        orderSource
      }
      logs{
        id
        status
        event
        createdAt
        createdBy
        operatorType
        description
      }
      remark
      consumer {
        isMember
        consumerId
        consumerName
        consumerEmail
        consumerLevel
        nickName
        phone
        avatarUrl
        unionId
        openId
      }
      comments{
        id
        createId
        content
        createdAt
        createdBy
        lastModifiedAt
        lastModifiedBy
        avatarUrl
      }
      invoice {
        invoiceId
        status
        type
        addTime
        updateTime
        auditTime
        printTime
        no
        purchaserName
        purchaserTaxpayerNumber
        purchaserAddress
        purchaserPhone
        purchaserBank
        purchaserBankAccount
        mobile
        email
      }
    }
  }
''';

const String orderStatisticsQuery = r'''
  query OrderStatistics {
    OrderStatistics {
      AllOrderQuantity
      UnpaidOrderQuantity
      ToShipOrderQuantity
      ShippedOrderQuantity
    }
  }
''';

const String orderShippedMutation = r'''
mutation updateOrder ($input:OrderShipInput){
orderShip(input: $input)
}
''';

const String orderCompletedMutation = r'''
mutation orderCompleted ($input: OrderCompletedInput){
orderCompleted(input:$input)
}
''';

const String orderCancelMutation = r'''
mutation cancelOrder ($input: OrderCancelInput) {
orderCancel(input: $input)
}
''';

const String orderDeleteMutation = r'''
  mutation deleteOrder ($orderNum: String){
    deleteOrder(orderNum: $orderNum)
  }
''';

const String paymentStartMutation = r'''
mutation paymentStart($input: PayInput!) {
paymentStart(input: $input) {
isSuccess,
wxPaymentRequest {
timeStamp,
nonceStr,
package,
signType,
paySign
},
aliPaymentRequest {
payWayOrderId,
orderStr
},
payment {
status
id
}
}
}
''';

const String expressCompanyFindQuery = r'''
query expressCompanyFind{
expressCompanyFind{
id
name
nameEn
img
code
isChecked
isDeleted
isEnabled
storeId
}
}
''';
