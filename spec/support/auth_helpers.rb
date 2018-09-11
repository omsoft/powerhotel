# spec/support/auth_helpers.rb
module AuthHelpers
  def authWithToken (user)
  	request.headers['X-AUTH-EMAIL'] = "#{user.email}"
    request.headers['X-AUTH-TOKEN'] = "#{user.authentication_token}"
  end
  def clearToken
  	request.headers['X-AUTH-EMAIL'] = nil
    request.headers['X-AUTH-TOKEN'] = nil
  end
end
