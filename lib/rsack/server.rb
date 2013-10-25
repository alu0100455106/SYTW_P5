module Rsack
   class Server
      def call(env)
         #["200",{}, "hello"]
         response = Rack::Response.new
         response.write("Hello world!")
         response.finish
      end
   end
end