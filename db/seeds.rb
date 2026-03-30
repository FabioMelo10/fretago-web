Motorista.delete_all
Proposta.delete_all
Pedido.delete_all

motoristas = [
  {
    nome: "Carlos Silva",
    telefone: "47988880001",
    email: "carlos.silva@fretago.com",
    cpf: "12345678901",
    renavam: "12345678901",
    placa_veiculo: "ABC1D23",
    tipo_veiculo: "Caminhonete",
    modelo_veiculo: "Hilux",
    ano_veiculo: 2020,
    cidade_atuacao: "Itajaí",
    veiculo: "Caminhonete",
    bairro: "Centro",
    password: "SenhaForte123",
    password_confirmation: "SenhaForte123",
    ativo: true
  },
  {
    nome: "Ana Souza",
    telefone: "47988880002",
    email: "ana.souza@fretago.com",
    cpf: "12345678902",
    renavam: "12345678902",
    placa_veiculo: "DEF1G23",
    tipo_veiculo: "Fiorino",
    modelo_veiculo: "Fiorino Endurance",
    ano_veiculo: 2021,
    cidade_atuacao: "Itajaí",
    veiculo: "Fiorino",
    bairro: "Vila Operária",
    password: "SenhaForte123",
    password_confirmation: "SenhaForte123",
    ativo: true
  },
  {
    nome: "Marcos Lima",
    telefone: "47988880003",
    email: "marcos.lima@fretago.com",
    cpf: "12345678903",
    renavam: "12345678903",
    placa_veiculo: "GHI1J23",
    tipo_veiculo: "Carro com rack",
    modelo_veiculo: "Duster",
    ano_veiculo: 2019,
    cidade_atuacao: "Navegantes",
    veiculo: "Carro com rack",
    bairro: "Fazenda",
    password: "SenhaForte123",
    password_confirmation: "SenhaForte123",
    ativo: true
  },
  {
    nome: "Fernanda Costa",
    telefone: "47988880004",
    email: "fernanda.costa@fretago.com",
    cpf: "12345678904",
    renavam: "12345678904",
    placa_veiculo: "JKL1M23",
    tipo_veiculo: "Utilitário",
    modelo_veiculo: "Doblo Cargo",
    ano_veiculo: 2018,
    cidade_atuacao: "Balneário Camboriú",
    veiculo: "Utilitário",
    bairro: "São Vicente",
    password: "SenhaForte123",
    password_confirmation: "SenhaForte123",
    ativo: true
  },
  {
    nome: "Rafael Oliveira",
    telefone: "47988880005",
    email: "rafael.oliveira@fretago.com",
    cpf: "12345678905",
    renavam: "12345678905",
    placa_veiculo: "NOP1Q23",
    tipo_veiculo: "Van utilitária",
    modelo_veiculo: "Master",
    ano_veiculo: 2022,
    cidade_atuacao: "Itajaí",
    veiculo: "Van utilitária",
    bairro: "Cordeiros",
    password: "SenhaForte123",
    password_confirmation: "SenhaForte123",
    ativo: true
  }
]

motoristas = Motorista.create!(motoristas)

itens = [
  "Sofá de 3 lugares",
  "Geladeira duplex",
  "Máquina de lavar",
  "Guarda-roupa desmontado",
  "Cama box casal",
  "Mesa de jantar 6 lugares",
  "Armário de cozinha",
  "TV 55 polegadas",
  "Escrivaninha",
  "Bicicleta"
]

enderecos = [
  "Bairro Centro, Itajaí",
  "Bairro Fazenda, Itajaí",
  "Bairro São Vicente, Itajaí",
  "Bairro Cordeiros, Itajaí",
  "Bairro Dom Bosco, Itajaí"
]

10.times do |i|
  pedido = Pedido.create!(
    nome_cliente: "Cliente #{i + 1}",
    telefone: "4799000000#{i}",
    endereco_retirada: enderecos.sample,
    endereco_entrega: enderecos.sample,
    item: itens[i],
    detalhes: "Pedido de demonstração gerado automaticamente.",
    status: "novo"
  )

  rand(0..3).times do
    motorista = motoristas.sample
    valor = rand(50..250)

    Proposta.create!(
      pedido:,
      motorista:,
      valor:,
      mensagem: "Consigo fazer hoje ainda por R$ #{valor}.",
      status: "enviada"
    )
  end
end

puts "Seeds criados com sucesso:"
puts "Motoristas: #{Motorista.count}"
puts "Pedidos: #{Pedido.count}"
puts "Propostas: #{Proposta.count}"

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
