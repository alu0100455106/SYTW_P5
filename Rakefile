desc "RPS"
task :default => :server

desc "Ejecutar rps en el servidor thin (puerto 8000)"
task :server do
  sh "rackup"
end

desc "Ejecutar el cliente con piedra"
task :rock do
  sh "ruby rps.rb ; curl -v 'http://localhost:9292/?eleccion=Piedra'"
end

desc "Ejecutar el cliente con papel"
task :paper do
  sh "ruby rps.rb ; curl -v 'http://localhost:9292/?eleccion=Papel'"
end

desc "Ejecutar el cliente con tijeras"
task :scissors do
  sh "ruby rps.rb ; curl -v 'http://localhost:9292/?eleccion=Tijeras'"
end

desc "Ejecutar todas las pruebas unitarias"
task :test do 
        sh "ruby -Ilib test/test_rps.rb"
end