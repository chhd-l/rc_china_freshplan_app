const String getAddressListQuery = r'''
  query consumerAddressFind($consumerId: String!){
    consumerAddressFind(consumerId: $consumerId) {
      id,
      consumerId,
      receiverName,
      phone,
      country,
      province,
      city,
      region,
      detail,
      postcode,
      isDefault,
      storeId,
    }
  }
''';

const String deleteAddressMutation = r'''
  mutation consumerAddressDelete ($id: String!){
    consumerAddressDelete(id: $id)
  }
''';

const String updateAddressMutation = r'''
  mutation consumerAddressUpdate ($input: ConsumerAddressUpdateInput!){
    consumerAddressUpdate(input: $input)
  }
''';

const String createAddressMutation = r'''
  mutation consumerAddressCreate($input: ConsumerAddressCreateInput!){
    consumerAddressCreate(input: $input){
      id
    }
  }
''';
