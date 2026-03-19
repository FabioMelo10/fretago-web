Motorista.delete_all
Proposta.delete_all
Pedido.delete_all

motoristas = [
  { nome: "Carlos Silva", telefone: "47988880001", veiculo: "Caminhonete", bairro: "Centro", ativo: true },
  { nome: "Ana Souza", telefone: "47988880002", veiculo: "Fiorino", bairro: "Vila Operária", ativo: true },
  { nome: "Marcos Lima", telefone: "47988880003", veiculo: "Carro com rack", bairro: "Fazenda", ativo: true },
  { nome: "Fernanda Costa", telefone: "47988880004", veiculo: "Utilitário", bairro: "São Vicente", ativo: true },
  { nome: "Rafael Oliveira", telefone: "47988880005", veiculo: "Caminhão 3/4", bairro: "Cordeiros", ativo: true }
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
    status: "aberto"
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
