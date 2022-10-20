const String appLoginQuery = r'''
  query allAuth($input: AuthInput!, $updateConsumerFiled: UpdateConsumerInput!, $operator: String) {
    allAuth(
      input: $input,
      updateConsumerFiled: $updateConsumerFiled,
      operator: $operator
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
        storeId,
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

const String sendCodeMutation = r'''
  mutation sendVerificationCode($input: SendVerificationCodeInput!) {
    sendVerificationCode(input: $input)
  }
''';

const String registerMutation = r'''
  mutation consumerRegister($input: ConsumerRegisterInput!) {
    consumerRegister(input: $input)
  }
''';

const String changePasswordMutation = r'''
  mutation consumerChangePassword($input: ConsumerChangePasswordInput!) {
    consumerChangePassword(input: $input)
  }
''';

const String checkCodeMutation = r'''
  mutation checkVerificationCode($input: CheckVerificationCodeInput!) {
    checkVerificationCode(input: $input)
  }
''';
