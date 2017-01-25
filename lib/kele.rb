require "kele/errors"
require "kele/roadmap"
require 'httparty'
require 'json'


class Kele
  include HTTParty
  include Roadmap
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

  def get_mentor_availability(mentor_id)
    url = api_url("mentors/#{mentor_id.to_s}/student_availability")
    response = self.class.get(url, headers:{ "authorization" => @auth_token} )
    body = JSON.parse(response.body)
    body.find_all {|x| x['booked'] == nil}.map {|x| x["starts_at"]}
  end

  def get_messages(arg = nil)
    response = self.class.get(api_url("message_threads"), headers: { "authorization" => @auth_token })
    body = JSON.parse(response.body)
    pages = (1..(response["count"]/10 + 1)).map do |n|
      self.class.get(api_url("message_threads"), body: { page: n }, headers: { "authorization" => @auth_token })
    end
  end

  def create_message(user_id, recipient_id, token, subject, stripped)
    self.class.post(api_url("messages"), body: {user_id: user_id, recipient_id: recipient_id, token: nil, subject: subject, stripped: stripped}, headers: { "authorization" => @auth_token })

  end

  private
   def api_url(endpoint)
     "https://www.bloc.io/api/v1/#{endpoint}"
   end
end
