require 'rspec'
require_relative '../model/coordenada.rb'
require_relative '../model/tablero.rb'

describe 'Tablero' do
  let(:tablero) { Tablero.new(10,10) }

  it 'el tablero se inicializa con todos los casilleros desocupados' do

    for x in 1..10
      for y in 1..10
        coord = Coordenada.new x,y
        expect( tablero.ocupado? coord).to be_falsey 
      end
    end

  end

  it 'ocupado? Coordenada.new 1,1 devuelve false si la posicion (1,1) esta desocupada' do
    expect(tablero.ocupado? Coordenada.new(1,1)).to be_falsey
  end

  it 'ocupado? Coordenada.new 1,1 devuelve true si la posicion (1,1) esta ocupada por alguna nave' do
    coord = Coordenada.new 1,1
    tablero.ubicar_nave Submarino.new, coord
    expect(tablero.ocupado? Coordenada.new(1,1)).to be_truthy
  end

  it 'ubicar_nave? Submarino.new, Coordenada.new(1,1) ocupa la posicion (1,1) con un submarino' do
    coord = Coordenada.new 1,1
    tablero.ubicar_nave Submarino.new, coord
    expect(tablero.ocupado? coord).to be_truthy
    expect(tablero.nave_en coord).to be_an_instance_of Submarino
  end

  it 'ubicar_nave? Crucero.new, Coordenada.new(1,1), Horizontal  ocupa las posicion (1,1) y (2,1) con un Crucero' do
    coord1 = Coordenada.new 1,1
    coord2 = Coordenada.new 2,1

    tablero.ubicar_nave Crucero.new, coord1, Horizontal

    expect(tablero.ocupado? coord1).to be_truthy
    expect(tablero.ocupado? coord2).to be_truthy

    expect(tablero.nave_en coord1).to be_an_instance_of Crucero
    expect(tablero.nave_en coord2).to be_an_instance_of Crucero
  end
  
  it 'ubicar_nave? Crucero.new, Coordenada.new(1,2), Vertical ocupa las posiciones (1,1) y (1,2) con un Crucero' do
    coord1 = Coordenada.new 1,2
    coord2 = Coordenada.new 1,1

    tablero.ubicar_nave Crucero.new, coord1, Vertical

    expect(tablero.ocupado? coord1).to be_truthy
    expect(tablero.ocupado? coord2).to be_truthy

    expect(tablero.nave_en coord1).to be_an_instance_of Crucero
    expect(tablero.nave_en coord2).to be_an_instance_of Crucero
  end


  it 'ubicar_nave? Destructor.new, Coordenada.new(1,1), Horizontal  ocupa las posiciones (1,1), (2,1), (3,1) con un Destructor' do
    coord1 = Coordenada.new 1,1
    coord2 = Coordenada.new 2,1
    coord3 = Coordenada.new 3,1

    tablero.ubicar_nave Destructor.new, coord1, Horizontal

    expect(tablero.ocupado? coord1).to be_truthy
    expect(tablero.ocupado? coord2).to be_truthy
    expect(tablero.ocupado? coord3).to be_truthy

    expect(tablero.nave_en coord1).to be_an_instance_of Destructor
    expect(tablero.nave_en coord2).to be_an_instance_of Destructor
    expect(tablero.nave_en coord3).to be_an_instance_of Destructor
  end

  it 'ubicar_nave? Destructor.new, Coordenada.new(1,3), Vertical ocupa las posiciones (1,1), (1,2), (1,3) con un Destructor' do
    coord1 = Coordenada.new 1,3
    coord2 = Coordenada.new 1,2
    coord3 = Coordenada.new 1,1

    tablero.ubicar_nave Destructor.new, coord1, Vertical

    expect(tablero.ocupado? coord1).to be_truthy
    expect(tablero.ocupado? coord2).to be_truthy
    expect(tablero.ocupado? coord3).to be_truthy

    expect(tablero.nave_en coord1).to be_an_instance_of Destructor
    expect(tablero.nave_en coord2).to be_an_instance_of Destructor
    expect(tablero.nave_en coord3).to be_an_instance_of Destructor
  end

  it 'ubicar_nave? Destructor.new, Coordenada.new(2,2), Vertical lanza una FueraDeTableroException y ninguna de las posiciones que debía ocupar estan ocupadas' do
    coord = Coordenada.new(1,2)
    expect{tablero.ubicar_nave  Destructor.new,coord, Vertical}.to raise_error FueraDeTableroException
    expect(tablero.ocupado? coord).to be_falsey 
  end
  
  it 'ubicar_nave? Crucero.new, Coordenada.new(10,1), Horizontal lanza una FueraDeTableroException y ninguna de las posiciones que debía ocupar están ocupadas' do
    coord = Coordenada.new(10,1)
    expect{tablero.ubicar_nave Crucero.new,coord, Horizontal}.to raise_error FueraDeTableroException
    expect(tablero.ocupado? coord).to be_falsey 
  end

  it 'ubicar_nave? Submarino.new, Coordenada.new(11,1) lanza una FueraDeTableroException' do
    expect{tablero.ubicar_nave Submarino.new,Coordenada.new(11,1) }.to raise_error FueraDeTableroException
  end

  it 'nave_en Coordenada.new(1,1) devuelve nil si no hay ninguna nave en esa posicion' do 
    expect(tablero.nave_en Coordenada.new(1,1)).to be nil
  end

  it 'nave_en Coordenada.new(1,1) devuelve un objeto submarino si en esa posicion esta ocupada por un Submarino' do 
    tablero.ubicar_nave Submarino.new, Coordenada.new(1,1)
    expect(tablero.nave_en Coordenada.new(1,1)).to be_an_instance_of Submarino 
  end

  it 'disparar Coordenada.new(1,1) devuelve false si no hay ninguna nave en esa posicion' do 
    expect(tablero.disparar Coordenada.new(1,1)).to be_falsey
  end

  it 'disparar Coordenada.new(1,1) devuelve true si hay nave en esa posicion y la nave queda averiada' do 
    coord = Coordenada.new(1,1)
    tablero.ubicar_nave Submarino.new, coord
    expect(tablero.disparar coord).to be_truthy
    expect(tablero.nave_en(coord).averiado?).to be_truthy

  end
end
