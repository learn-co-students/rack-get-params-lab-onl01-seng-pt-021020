class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/) #route 
      @@items.each do |item|
        resp.write "#{item}\n" #this list all the items in the browser
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      if @@cart.empty?  
        resp.write "Your cart is empty"
      else @@cart.each do |c|
        resp.write "#{c}\n"  #list out items in the cart
        end
      end
    elsif req.path.match(/add/)  
      search_item = req.params["item"]
      if @@items.include?(search_item)
        @@cart << search_item   #if the item search for is avaiable, place in the cart
        resp.write "added #{search_item}" 
      else
        resp.write "We don't have that item"
      end    
      else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

end
