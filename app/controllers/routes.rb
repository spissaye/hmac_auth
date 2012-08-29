HmacAuth.controllers do
  before do

  end

  get :index do
    "Hello World!"
  end

  get :test do

  end

  error 500 do
    puts env['sinatra.error'].inspect
    puts env['sinatra.error'].backtrace.join("\n \n")
  end

end