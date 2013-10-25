desc "Ejecutando rps en el servidor thin (puerto 9292)"
task :default do
   sh "rackup"
end


desc "Ejecutar todas las pruebas unitarias"
task :test do 
   sh "ruby -Itest -Ilib test/test_rps.rb"
end

desc "Ejecutar todos los test rspec"
task :spec do
   sh "rspec -Ilib -Ispec spec/rsack/server_spec.rb"
end