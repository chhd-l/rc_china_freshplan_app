const String subscriptionFindByConsumerIdQuery = r'''
query subscriptionFindByConsumerId {
subscriptionFindByConsumerId {
type
cycle
source
freshType
status
totalDeliveryTimes
consumer {
id
avatarUrl
nickName
}
pet {
id
name
gender
type
breedCode
breedName
image
isSterilized
birthday
consumerId
recentHealth
recentWeight
recentPosture
targetWeight
}
currentDeliveringSequence
currentDeliveredSequence
firstDeliveryTime
createNextDeliveryTime
completedDeliveries{
sequence
createdAt
shipmentDate
status
orderId
orderState {
orderState
createdAt
createdBy
lastModifiedAt
lastModifiedBy
orderType
storeId
}
lineItems {
id
spuId
skuNo
spuNo
skuName
isGift
spuName
productSpecifications
pic
price
num
productAttributeAndValues {
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
}
planingDeliveries {
sequence
createdAt
shipmentDate
status
orderId
orderState {
orderState
createdAt
createdBy
lastModifiedAt
lastModifiedBy
orderType
storeId
}
lineItems {
id
skuNo
spuId
spuNo
isGift
skuName
spuName
productSpecifications
pic
price
num
productAttributeAndValues {
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
}
id
no
status
subscriptionAt
createdAt
address {
city
country
detail
id
phone
postcode
province
receiverName
region
}
productList {
id
quantity
quantityRule
subscriptionRecommendRuleId
id
spuNo
name
cardName
description
type
brandId
categoryId
shelvesStatus
defaultImage
salesStatus
weight
weightUnit
parcelSizeLong
parcelSizeLongUnit
parcelSizeHeight
parcelSizeHeightUnit
parcelSizeWidth
parcelSizeWidthUnit
storeId
specifications {
id
specificationName
specificationNameEn
specificationDetails {
id
productId
specificationId
specificationDetailName
specificationDetailNameEn
storeId
}
}
variants {
id
isSupport100
productId
skuNo
num
eanCode
name
skuType
stock
marketingPrice
listPrice
shelvesStatus
shelvesTime
storeId
defaultImage
subscriptionStatus
feedingDays
subscriptionPrice
specificationRelations {
specificationId
specificationDetailId
variantId
relId
}
}
attributeValueRelations {
attributeName
attributeNameEn
attributeValueName
attributeValueNameEn
relId
attributeId
attributeValueId
productId
}
}
benefits {
id
spuNo
name
cardName
description
type
brandId
categoryId
shelvesStatus
defaultImage
salesStatus
weight
weightUnit
parcelSizeLong
parcelSizeLongUnit
parcelSizeHeight
parcelSizeHeightUnit
parcelSizeWidth
parcelSizeWidthUnit
storeId
specifications {
id
specificationName
specificationNameEn
specificationDetails {
id
productId
specificationId
specificationDetailName
specificationDetailNameEn
storeId
}
}
variants {
id
num
isSupport100
productId
skuNo
eanCode
name
skuType
stock
marketingPrice
listPrice
shelvesStatus
shelvesTime
storeId
defaultImage
subscriptionStatus
feedingDays
subscriptionPrice
specificationRelations {
specificationId
specificationDetailId
variantId
relId
}
}
attributeValueRelations {
attributeName
attributeNameEn
attributeValueName
attributeValueNameEn
relId
attributeId
attributeValueId
productId
}
quantity
quantityRule
subscriptionRecommendRuleId
}
comments {
id
createdAt
createdBy
id
lastModifiedAt
lastModifiedBy
}
price {
productPrice
deliveryPrice
totalPrice
taxRate
discountsPrice
}
}
}
''';

const String subscriptionGetQuery = r'''
query subscriptionGet($id: ID!) {
subscriptionGet(id: $id) {
type
source
cycle
freshType
status
totalDeliveryTimes
consumer {
id
avatarUrl
nickName
phone
email
}
pet {
id
name
gender
type
breedCode
breedName
image
isSterilized
birthday
consumerId
recentHealth
recentWeight
recentPosture
targetWeight
}
currentDeliveringSequence
currentDeliveredSequence
firstDeliveryTime
createNextDeliveryTime
completedDeliveries{
sequence
createdAt
shipmentDate
status
orderId
orderState {
orderState
createdAt
createdBy
lastModifiedAt
lastModifiedBy
orderType
storeId
}
lineItems {
id
skuNo
spuNo
spuId
skuName
isGift
spuName
productSpecifications
pic
price
num
productAttributeAndValues {
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
}
planingDeliveries {
sequence
createdAt
shipmentDate
status
orderId
orderState {
orderState
createdAt
createdBy
lastModifiedAt
lastModifiedBy
orderType
storeId
}
lineItems {
id
skuNo
spuNo
isGift
skuName
spuName
spuId
productSpecifications
pic
price
num
productAttributeAndValues {
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
}
id
no
status
subscriptionAt
createdAt
address {
city
country
detail
id
phone
postcode
province
receiverName
region
}
productList {
id
quantity
quantityRule
subscriptionRecommendRuleId
id
spuNo
name
cardName
description
type
brandId
categoryId
shelvesStatus
defaultImage
salesStatus
weight
weightUnit
parcelSizeLong
parcelSizeLongUnit
parcelSizeHeight
parcelSizeHeightUnit
parcelSizeWidth
parcelSizeWidthUnit
storeId
specifications {
id
specificationName
specificationNameEn
specificationDetails {
id
productId
specificationId
specificationDetailName
specificationDetailNameEn
storeId
}
}
variants {
id
isSupport100
productId
skuNo
num
eanCode
name
skuType
stock
marketingPrice
listPrice
shelvesStatus
shelvesTime
storeId
defaultImage
subscriptionStatus
feedingDays
subscriptionPrice
specificationRelations {
specificationId
specificationDetailId
variantId
relId
}
}
attributeValueRelations {
attributeName
attributeNameEn
attributeValueName
attributeValueNameEn
relId
attributeId
attributeValueId
productId
}
}
coupons{
id
subscriptionRecommendRuleId
couponId
quantityRule
quantity
voucher {
id
voucherId
voucherName
voucherCode
}
num
}
benefits {
id
spuNo
name
cardName
description
type
brandId
categoryId
shelvesStatus
defaultImage
salesStatus
weight
weightUnit
parcelSizeLong
parcelSizeLongUnit
parcelSizeHeight
parcelSizeHeightUnit
parcelSizeWidth
parcelSizeWidthUnit
storeId
specifications {
id
specificationName
specificationNameEn
specificationDetails {
id
productId
specificationId
specificationDetailName
specificationDetailNameEn
storeId
}
}
variants {
id
num
isSupport100
productId
skuNo
eanCode
name
skuType
stock
marketingPrice
listPrice
shelvesStatus
shelvesTime
storeId
defaultImage
subscriptionStatus
feedingDays
subscriptionPrice
specificationRelations {
specificationId
specificationDetailId
variantId
relId
}
}
attributeValueRelations {
attributeName
attributeNameEn
attributeValueName
attributeValueNameEn
relId
attributeId
attributeValueId
productId
}
quantity
quantityRule
subscriptionRecommendRuleId
}
comments {
id
createId
avatarUrl
content
createdAt
createdBy
lastModifiedAt
lastModifiedBy
}
logs {
createdAt
createdBy
event
id
request
response
status
operatorType
}
price {
productPrice
deliveryPrice
totalPrice
taxRate
discountsPrice
}
}
}
''';

const String  subscriptionCancelMutation = r'''
mutation subscriptionCancel($subscriptionId: String!, $subscriptionType: SubscriptionType!, $agreementNo: String, $aliPayUserId: String,$projectName:ProjectNameEnum!) {
subscriptionCancel(subscriptionId: $subscriptionId, subscriptionType: $subscriptionType, agreementNo: $agreementNo, aliPayUserId: $aliPayUserId,projectName:$projectName)
}
''';

const String subscriptionUpdateAddressMutation = r'''
mutation subscriptionUpdateAddress($id: String!, $address: SubscriptionAddressInput!) {
subscriptionUpdateAddress(id: $id, address: $address)
}
''';

