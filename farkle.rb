module Farkle
end

Dir["./farkle/*.rb"].each {|file| require file }

game = Farkle::Game.new
game.start
