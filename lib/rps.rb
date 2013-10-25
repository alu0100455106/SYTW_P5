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
   
      def set_env(env)
         @env = env
         @session = env['rack.session']
      end

      def win 
         return @session['win'].to_i if @session['win']
         @session['win'] = 0
      end

      def win=(value)
         @session['win'] = value
      end      
      
      
      ###
      
      def lost
         return @session['lost'].to_i if @session['lost']
         @session['lost'] = 0
      end      
      
      def lost=(value)
         @session['lost'] = value
      end         
      
      ###
      
      def tied
         return @session['tied'].to_i if @session['tied']
         @session['tied'] = 0
      end      
      
      def tied=(value)
         @session['tied'] = value
      end   
          
      
      
      
      def call(env)
         
         set_env(env)
         req = Rack::Request.new(env)
         
         #req.env.keys.sort.each { |x| puts "#{x} => #{req.env[x]}" }
           
         computer_throw = @throws.sample
         player_throw = req.GET["choice"]
         
         answer = 
            if !@throws.include?(player_throw)
               "Choose one"
            elsif player_throw == computer_throw
               self.tied= self.tied + 1
               "There is a tie"
            elsif computer_throw == @defeat[player_throw]
               self.win += 1
               "Well done. You win; #{player_throw} beats #{computer_throw}" 
            else
               self.lost += 1
               "Computer wins; #{computer_throw} defeats #{player_throw}"
            end
         
     
            
            
         resultado = ""
         if !answer.empty?
         resultado.insert(0, "Your chose: <img src='./public/images/#{player_throw}.gif'>      Computer chose: <img src='./public/images/#{computer_throw}.gif'>")
         end            
            
         engine = Haml::Engine.new File.open("views/index.haml").read
         res = Rack::Response.new
                  
         #Añadimos la info al template
         res.write engine.render({},
            :answer => answer,
            :resultado => resultado,
            :player_throw => player_throw,
            :ganadas => self.win,
            :perdidas => self.lost,
            :empates => self.tied,
            :jugadas => self.win + self.lost + self.tied)
         res.finish
         
      end # call
   end # App
end # RockPaperScissors


                            
                       
                       