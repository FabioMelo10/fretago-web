class CreatePedidos < ActiveRecord::Migration[7.2]
  def change
    create_table :pedidos do |t|
      t.string :nome_cliente, null: false
      t.string :telefone, null: false
      t.string :endereco_retirada, null: false
      t.string :endereco_entrega, null: false
      t.string :item, null: false
      t.text :detalhes
      t.string :status, null: false

      t.timestamps
    end
  end
end
