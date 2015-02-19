require 'net/http'
require 'rubygems'
require 'json'

class Oauth2Controller < ApplicationController
  CLIENT_ID = "AE2EMOIHPTKBJBWVE7"
  REDIRECT_URI = "https://www.eventbrite.com/oauth/authorize?response_type=code&client_id="
  CLIENT_SECRET = "ZKEVFWHU5HFPUAM4QEAOQ3R2RMZQTBKV3KGHAMZA5W6KET6DA2"
  GETTOKEN_URI = "https://www.eventbrite.com/oauth/token"

  def auth
    redirect_to REDIRECT_URI+CLIENT_ID
  end

  def welcome
  end

  def content
    code = params[:code]
    res = Net::HTTP.post_form(URI(GETTOKEN_URI), 'code' => code, 'client_secret' => CLIENT_SECRET, 'client_id' => CLIENT_ID, 'grant_type' => 'authorization_code') 
    hash_control  = JSON.parse(res.body)
    token = hash_control["access_token"]

    uri = URI('https://www.eventbriteapi.com/v3/users/me/')
    req2 = Net::HTTP::Get.new(uri)
    req2['Authorization'] = 'Bearer ' + token

    res2 = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') {|http|
      http.request(req2)
    }

   puts res2.content_type

   @cont = res2.body

   render json: res2.body
  end
end
