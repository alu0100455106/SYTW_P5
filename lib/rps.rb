require 'rack/request'
require 'rack/response'
require 'haml'


module RockPaperScissors

   class App
               
      def initialize(app = nil) 
         @app = app
         @content_type = :html
         @defeat = {'rock' => 'scissors', 'paper' => 'rock', 'scissors' => 'paper'}
         @throws = @defeat.keys
      end
      
      def call(env)
         req = Rack::Request.new(env)
         
         req.env.keys.sort.each { |x| puts "#{x} => #{req.env[x]}" }
  
         
         computer_throw = @throws.sample
         player_throw = req.GET["choice"]
         answer = 
            if !@throws.include?(player_throw)
               "Choose one"
            elsif player_throw == computer_throw
               "<pre>There is a tie     </pre>"
            elsif computer_throw == @defeat[player_throw]
               "<pre>Well done. You win; #{player_throw} beats #{computer_throw}        </pre>" 
            else
               "<pre>Computer wins; #{computer_throw} defeats #{player_throw}   </pre>"
            end

         resultado = ""
         if !answer.empty?
         resultado.insert(0, "<pre>Your chose: <img src='./public/images/#{player_throw}.gif'>      Computer chose: <img src='./public/images/#{computer_throw}.gif'>             </pre>")
         end            
            
         engine = Haml::Engine.new File.open("views/index.haml").read
         res = Rack::Response.new
         
         #Añadimos la info al template
         res.write engine.render({},
            :answer => answer,
            :resultado => resultado,
            :player_throw => player_throw,               
            :throws => @throws)        
         res.finish
         
      end # call
   end # App
end # RockPaperScissors

