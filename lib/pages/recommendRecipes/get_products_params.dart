const getProductsParams={
  "query": "\n  query getProducts(\$input:EsProductPageInput)\n    {\n      productFindPageByEs(input:\$input) {\n        limit\n        offset\n        total\n        records{\n            id\n          spuNo\n          name\n          cardName\n          description\n          type\n          brandId\n          categoryId \n          shelvesStatus\n          defaultImage\n          salesStatus\n          weight\n          weightUnit\n          parcelSizeLong\n          parcelSizeLongUnit\n          parcelSizeHeight\n          parcelSizeHeightUnit\n          parcelSizeWidth\n          parcelSizeWidthUnit\n          storeId\n          isDeleted\n          specifications {\n            id\n            specificationName\n            specificationNameEn\n            specificationDetails{\n              id\n              productId \n              specificationId \n              specificationDetailName\n              specificationDetailNameEn\n              storeId\n              isDeleted\n            }\n            isDeleted\n          }\n          variants {\n            id\n            productId \n            skuNo\n            eanCode\n            name\n            skuType\n            isSupport100\n            stock\n            marketingPrice\n            listPrice\n            shelvesStatus\n            shelvesTime\n            storeId\n            defaultImage\n            subscriptionStatus\n            feedingDays\n            subscriptionPrice\n            specificationRelations  {\n              specificationId\n              specificationDetailId\n             variantId\n              relId\n            }\n          }\n          asserts {\n            id\n            productId \n           variantId\n            artworkUrl\n            type\n            storeId\n          }\n          attributeValueRelations {\n            attributeName\n            attributeNameEn\n            attributeValueName\n            attributeValueNameEn\n            relId\n            attributeId\n            attributeValueId\n            productId \n          }\n        }\n      }\n    }\n",
  "variables": {
    "input": {
      "limit": 4,
      "sample": {
        "storeId": "39b6444b-683b-4915-8b75-5d8403f40a02"
      },
      "withTotal": true,
      "offset": 0
    }
  }
};