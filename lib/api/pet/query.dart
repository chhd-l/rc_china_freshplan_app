const String getPetListQuery = r'''
  query consumerPetFind($consumerId: String){
    consumerPetFind(consumerId: $consumerId) {
      id,
      name,
      gender,
      type,
      breedCode,
      breedName,
      image,
      isSterilized,
      birthday,
      recentWeight,
      recentHealth,
      recentPosture,
      targetWeight,
      subscriptionNo
    }
  }
''';

const String getPetDetailQuery = r'''
  query getPet($id: String!) {
    consumerPetGet(id: $id) {
      id,
      name,
      gender,
      type,
      breedCode,
      breedName,
      image,
      isSterilized,
      birthday,
      recentWeight,
      recentHealth,
      recentPosture,
      targetWeight,
      subscriptionNo
    }
  }
''';

const String createPetMutation = r'''
  mutation consumerPetCreate ($input: ConsumerPetCreateInput!){
    consumerPetCreate(input: $input) {
      id
    }
  }
''';

const String updatePetMutation = r'''
  mutation updatePet ($input: ConsumerPetUpdateInput!){
    consumerPetUpdate(input: $input)
  }
''';

const String deletePetMutation = r'''
  mutation consumerPetDelete ($id: String!){
    consumerPetDelete(id:$id)
  }
''';
