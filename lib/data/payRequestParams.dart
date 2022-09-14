const getPayInfoParams={
  "query": "\nmutation subscriptionCreateAndPay (\$input: SubscriptionInput!, \$payWayId:String!){\n    subscriptionCreateAndPay(input: \$input,payWayId:\$payWayId) {\n        subscription {\n            id\n            no\n        }\n        paymentStartResult {\n            isSuccess\n            payment {\n                amount\n                currency\n                consumerAccountOpenId\n                consumerId\n                details{\n                    code\n                    id\n                    paymentId\n                    value\n                }\n                id\n                paymentFinishTime\n                paymentStartTime\n                payWayCode\n                payWayId\n                payWayOrderId\n                payWayPrePayId\n                status\n                orderId\n                orderNo\n            }\n            wxPaymentRequest {\n                nonceStr\n                package\n                paySign\n                signType\n                timeStamp\n            }\n            aliPaymentRequest {\n                payWayOrderId\n                orderStr\n            }\n        }\n    }\n  }\n",
  "variables": {
    "input": {
      "description": "description",
      "type": "FRESH_PLAN",
      "cycle": null,
      "freshType": null,
      "voucher": null,
      "consumer": {
        "id": "7431e1c7-b12b-42ab-9897-d18ef1e2eee1",
        "avatarUrl": "https://tfs.alipayobjects.com/images/partner/T1dKReXadoXXXXXXXX",
        "level": "新手铲屎官",
        "phone": "13590415629",
        "nickName": "Timyee",
        "name": null,
        "email": null,
        "points": 0,
        "account": {
          "unionId": null,
          "openId": "2088102181402630",
          "isWXGroupVip": false
        }
      },
      "pet": {
        "name": "mm",
        "gender": "MALE",
        "type": "DOG",
        "breedCode": "55",
        "breedName": "贵宾(泰迪)",
        "image": "https://dtcdata.oss-cn-shanghai.aliyuncs.com/asset/image/dog-default.png",
        "isSterilized": false,
        "birthday": "2022-03-31T00:00:00.000Z",
        "id": "fcf5ff23-2786-bc90-1c9d-345ac4a51fa0",
        "recentWeight": 1,
        "targetWeight": 6,
        "recentPosture": "STANDARD",
        "recentHealth": "NONE"
      },
      "source": "ALIPAY_MINI_PROGRAM",
      "address": {
        "id": "844ce269-e237-8c2e-ae6b-5609b0f93b27",
        "receiverName": "收货a",
        "phone": "13110111211",
        "country": null,
        "province": "浙江省",
        "city": "杭州市",
        "region": "滨江区",
        "detail": "详细地址1",
        "postcode": null
      },
      "productList": [
        {
          "id": "34ef1fe0-de75-8684-760d-8d38af9d888a",
          "spuNo": "1001",
          "name": "鸡肉料理",
          "cardName": null,
          "description": "<p><br></p><p>鸡肉、红薯、南瓜、菠菜</p><p><br></p><p><br></p>",
          "type": "REGULAR",
          "brandId": "B3",
          "categoryId": "56",
          "shelvesStatus": true,
          "defaultImage": "https://dtc-platform.oss-cn-shanghai.aliyuncs.com/imgs/1660560522338.jpg",
          "salesStatus": true,
          "weight": null,
          "weightUnit": null,
          "parcelSizeLong": null,
          "parcelSizeLongUnit": null,
          "parcelSizeHeight": null,
          "parcelSizeHeightUnit": null,
          "parcelSizeWidth": null,
          "parcelSizeWidthUnit": null,
          "storeId": "39b6444b-683b-4915-8b75-5d8403f40a02",
          "specifications": [
            {
              "id": "4a73ccdf-0916-d0af-2fb3-0aceb6e9bf92",
              "specificationName": "规格",
              "specificationNameEn": "规格",
              "specificationDetails": [
                {
                  "id": "0921de1c-c801-dec6-e098-78c82020efb6",
                  "productId": null,
                  "specificationId": "4a73ccdf-0916-d0af-2fb3-0aceb6e9bf92",
                  "specificationDetailName": "80G*7",
                  "specificationDetailNameEn": "80G*7",
                  "storeId": null
                }
              ]
            }
          ],
          "variants": {
            "id": "a2286667-836d-b5d6-e003-18a7a8fed571",
            "productId": "34ef1fe0-de75-8684-760d-8d38af9d888a",
            "skuNo": "100101",
            "eanCode": "100101",
            "name": "鸡肉料理",
            "skuType": "REGULAR",
            "isSupport100": true,
            "stock": 940,
            "marketingPrice": 201,
            "listPrice": 223,
            "shelvesStatus": true,
            "shelvesTime": null,
            "storeId": null,
            "defaultImage": "https://dtc-platform.oss-cn-shanghai.aliyuncs.com/imgs/1662102313848.png",
            "subscriptionStatus": 1,
            "feedingDays": 7,
            "subscriptionPrice": 102,
            "specificationRelations": [
              {
                "specificationId": "4a73ccdf-0916-d0af-2fb3-0aceb6e9bf92",
                "specificationDetailId": "0921de1c-c801-dec6-e098-78c82020efb6",
                "variantId": "a2286667-836d-b5d6-e003-18a7a8fed571",
                "relId": null
              }
            ],
            "num": 6
          },
          "attributeValueRelations": [
            {
              "attributeName": "干/湿",
              "attributeNameEn": "Technology",
              "attributeValueName": "湿粮",
              "attributeValueNameEn": "Wet food",
              "relId": "66a7ab6d-9b35-b39e-73b5-fe8c633867cb",
              "attributeId": "product_attribute_011",
              "attributeValueId": "attribute_value_009",
              "productId": "34ef1fe0-de75-8684-760d-8d38af9d888a"
            }
          ]
        }
      ],
      "benefits": null,
      "coupons": null,
      "remark": "",
      "firstDeliveryTime": "2022-09-09T00:00:00.000Z",
      "totalDeliveryTimes": 6
    },
    "payWayId": "e47dfb0f-1d3f-11ed-8ae8-00163e02a659",
    "storeId": "39b6444b-683b-4915-8b75-5d8403f40a02",
    "operator": "Timyee"
  }
};