require "test/unit"
require "rack/test"
require 'rps'


module RockPaperScissors
   
class RockPaperScissorsAppTest < Test::Unit::TestCase
   include Rack::Test::Methods
   
   def app
      Rack::Builder.new do
         run ::RockPaperScissors::App.new
      end.to_app
   end
   
   def test_index
      get "/"
      assert last_response.ok?
   end
   
   def test_rock
      get "/?choise=rock"
      assert last_response.ok?
   end

   def test_paper
      get "/?choise=paper"
      assert last_response.ok?
   end
   
   def test_scissors
      get "/?choise=scissors"
      assert last_response.ok?
   end
   
  
   def test_head
      get "/"
      assert last_response.body.include? ("RPS con Haml.")
   end    
   
   def test_body
      get "/"
      assert last_response.body.include? ("ETSII - Universidad de La Laguna - 2013")
   end
   
   def test_falla
      get "/"
      assert last_response.body.include? ("Esto no debería aparecer en el body")
   end   

   def test_static_asset
      get "/public/css/custom.css"
      assert last_response.ok?
   end
    
end   

end