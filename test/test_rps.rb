require "test/unit"
require "./lib/rps"
require "rack/test"

class RPS_Test < Test::Unit::TestCase
   include Rack::Test::Methods
   
   def app
      Rack::Builder.new do
         run RockRaperScissors::App.new
      end
   end
   
   def test_home
      get "/"
      assert last_response.ok?
   end
   
   def test_rock
      get "/?choise=rock"
      assert last_response.ok?
   end.

   def test_paper
      get "/?choise=paper"
      assert last_response.ok?
   end
   
   def test_scissors
      get "/?choise=scissors"
      assert last_response.ok?
   end
   
   #def test_head
   #   get "/"
   #   assert_match "<title>RPS con Haml.</title>"last_response.body
   #end 
   
   def test_head
      get "/"
      assert last_response.head.include? ("RPS con Haml.")
   end    
   
   def test_body
      get "/"
      assert last_response.body.include? ("ETSII - Universidad de La Laguna - 2013")
   end

   def test_static_asset
      get "/public/css/custom.css"
      asser last_response.ok?
   end
   
end