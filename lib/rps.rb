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
   
#       def set_env(env)
#          @env = env
#          @session = env['rack.session']
#       end
# 
#       def win 
#          return @session['win'].to_i if @session['win']
#          @session['win'] = 0
#       end
# 
#       def win=(value)
#          @session['win'] = value
#       end      
#       
#       

#       
#       def lost
#          return @session['lost'].to_i if @session['lost']
#          @session['lost'] = 0
#       end      
#       
#       def lost=(value)
#          @session['lost'] = value
#       end         
#       

#       
#       def tied
#          return @session['tied'].to_i if @session['tied']
#          @session['tied'] = 0
#       end      
#       
#       def tied=(value)
#          @session['tied'] = value
#       end   
          
      
      
      
      def call(env)
         
#          set_env(env)
         req = Rack::Request.new(env)
         
         #req.env.keys.sort.each { |x| puts "#{x} => #{req.env[x]}" }
           
         computer_throw = @throws.sample
         player_throw = req.GET["choice"]
         
         answer = 
            if !@throws.include?(player_throw)
               "Choose one"
            elsif player_throw == computer_throw
               @plays['ties'] += 1
#                self.tied= self.tied + 1
               "There is a tie"
            elsif computer_throw == @defeat[player_throw]
               @plays['wins'] += 1
#                self.win += 1
               "Well done. You win; #{player_throw} beats #{computer_throw}" 
            else
               @plays['defeats'] += 1
#                self.lost += 1
               "Computer wins; #{computer_throw} defeats #{player_throw}"
            end
         
     
            
            
         resultado = ""
         if !answer.empty?
         resultado.insert(0, "Your chose: <img src='./public/images/#{player_throw}.gif'>      Computer chose: <img src='./public/images/#{computer_throw}.gif'>")
         end            
            
         engine = Haml::Engine.new File.open("views/index.haml").read
         res = Rack::Response.new
                       
#          res.set_cookie("ganadas", {:value => @session['win'], :path => "/", :domain => "", :expires => Time.now+3600})
#          res.set_cookie("empates", {:value => @session['tied'], :path => "/", :domain => "", :expires => Time.now+3600})
#          res.set_cookie("perdidas", {:value => @session['lost'], :path => "/", :domain => "", :expires => Time.now+3600})        

         res.set_cookie("ganadas", {:value => @plays['wins'], :path => "/", :expire => Time.now+24*60*60})
         res.set_cookie("perdidas", {:value => @plays['defeats'], :path => "/", :expire => Time.now+24*60*60})         
         res.set_cookie("empates", {:value => @plays['ties'], :path => "/", :expire => Time.now+24*60*60})         
         
         #Añadimos la info al template
         res.write engine.render({},
            :answer => answer,
            :resultado => resultado,
            :player_throw => player_throw,
#             :ganadas => self.win,
#             :perdidas => self.lost,
#             :empates => self.tied,
#             :jugadas => self.win + self.lost + self.tied)
            :play => @plays)
         res.finish
         
      end # call
   end # App
end # RockPaperScissors


                            
                       
                       