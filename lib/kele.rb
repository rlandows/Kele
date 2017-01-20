require "kele/errors"
require 'httparty'
require 'json'


class Kele
  include HTTParty
  #base_uri "https://www.bloc.io/api/v1/"

  def initialize(email, password)

     response = self.class.post(api_url("sessions"), body: {"email": email, "password": password})
     raise InvalidStudentCodeError.new() if response.code == 401
     @auth_token = response["auth_token"]
  end

  def get_me
    url = "https://www.bloc.io/api/v1/users/me"
    response = self.class.get(url, headers: { "authorization" => @auth_token })
    JSON.parse(response.body)
  end

  private
   def api_url(endpoint)
     "https://www.bloc.io/api/v1/#{endpoint}"
   end
end