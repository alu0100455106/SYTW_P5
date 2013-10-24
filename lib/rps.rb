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
         @plays = {'wins' => 0, 'defeats' => 0, 'ties' => 0}
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
               @plays['ties'] += 1
               "There is a tie"
            elsif computer_throw == @defeat[player_throw]
               @plays['wins'] += 1
               "Well done. You win; #{player_throw} beats #{computer_throw}" 
            else
               @plays['defeats'] += 1
               "Computer wins; #{computer_throw} defeats #{player_throw}"
            end

         resultado = ""
         if !answer.empty?
         resultado.insert(0, "Your chose: <img src='./public/images/#{player_throw}.gif'>      Computer chose: <img src='./public/images/#{computer_throw}.gif'>")
         end            
            
         engine = Haml::Engine.new File.open("views/index.haml").read
         res = Rack::Response.new
         
         #res.set_cockie("cookie", {:value => @plays, :path => "/", :expire => Time.now+24*60*60})
         
         #Añadimos la info al template
         res.write engine.render({},
            :answer => answer,
            :resultado => resultado,
            :plays => @plays,
            :player_throw => player_throw)
         res.finish
         
      end # call
   end # App
end # RockPaperScissors


                            
                       
                       