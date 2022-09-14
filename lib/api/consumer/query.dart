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
