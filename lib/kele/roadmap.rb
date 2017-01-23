module Roadmap
  def get_roadmap(roadmap_id)
    url = api_url('roadmaps/#{roadmap_id}')
    response = self.class.get(url, headers: {"authorization" => @auth_token})
    body = JSON.parse(response.body)
  end

  def get_checkpoint(checkpoint_id)
    url = api_url('checkpoints/#{checkpoint_id}')
    response = self.class.get(url, headers: {"authorization" => @auth_token})
    body = JSON.parse(response.body)
  end

  private
   def api_url(endpoint)
     "https://www.bloc.io/api/v1/#{endpoint}"
   end
end
