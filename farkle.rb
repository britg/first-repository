module Farkle
end

Dir["./farkle/*.rb"].each {|file| require file }

# To start a game do:
# >irb
# irb> require "./farkle"
# irb> game = Farkle::Game.new
# irb> game.start
