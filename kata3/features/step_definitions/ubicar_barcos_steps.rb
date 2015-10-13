require_relative '../../model/batalla_naval.rb'
# Background 

Given(/^un tablero de (\d+) x (\d+)$/) do |ancho, alto|
  @juego = BatallaNaval.new(ancho, alto)
end

Given(/^la posicion \((\d+),(\d+)\) del tablero del jugador esta ocupada$/) do |x, y|
  @jugador = 1 
  @juego.ubicar_nave(@jugador, "submarino", x.to_i, y.to_i)
end

# Scenario 1

When(/^ubico el submarino en la posicion \((\d+),(\d+)\)$/) do |x, y|
  @juego.ubicar_nave(@jugador, "submarino", x.to_i, y.to_i)
end

Then(/^el submarino queda ubicado ocupando la posicion \((\d+),(\d+)\)$/) do |x, y|
  expect(@juego.ocupado? @jugador,x.to_i,y.to_i).to be_truthy
  expect(@juego.nave_en @jugador,x.to_i,y.to_i).to be_an_instance_of Submarino
end

When(/^ubico el crucero horizontalmente en la posicion \((\d+),(\d+)\)$/) do |x,y|
  @juego.ubicar_nave @jugador, "crucero", x.to_i, y.to_i, "horizontal"
end

Then(/^el crucero queda ubicado ocupando las posiciones \((\d+),(\d+)\) y \((\d+),(\d+)\)$/) do |x1, y1, x2, y2|
  expect(@juego.ocupado? @jugador,x1.to_i,y1.to_i).to be_truthy
  expect(@juego.nave_en @jugador,x1.to_i,y1.to_i).to be_an_instance_of Crucero

  expect(@juego.ocupado? @jugador,x2.to_i,y2.to_i).to be_truthy
  expect(@juego.nave_en @jugador,x2.to_i,y2.to_i).to be_an_instance_of Crucero
end
