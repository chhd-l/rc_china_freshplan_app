const String appLoginQuery = r'''
  query appLogin ($phone: String!, $storeId: String!) {
    appLogin (phone: $phone, storeId: $storeId) {
      userInfo {
        id,
        name,
        gender,
        avatarUrl,
        nickName,
        email,
        phone,
        level,
        points,
        defaultConsumerAddressId,
        lastLoginTime,
        storeId
      },
      access_token,
      consumerAccount {
        id,
        consumerId,
        openId,
        unionId,
        userType,
        followStatus,
        followedTime,
        unfollowedTime,
        storeId
      }
    }
  }
''';

const String changeTokenQuery = r'''
  query wxLogin($token: String!) {
    wxLogin(
      token: $token
    ) {
      userInfo {
        id,
        name,
        gender,
        avatarUrl,
        nickName,
        email,
        phone,
        level,
        points,
        defaultConsumerAddressId,
        lastLoginTime,
        storeId
      },
      access_token
    }
  }
''';

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