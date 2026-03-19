class CreateProposta < ActiveRecord::Migration[7.2]
  def change
    create_table :propostas do |t|
      t.references :pedido, null: false, foreign_key: true
      t.references :motorista, null: false, foreign_key: { to_table: :motoristas }
      t.decimal :valor, precision: 10, scale: 2, null: false
      t.text :mensagem
      t.string :status, null: false

      t.timestamps
    end

    add_index :propostas, [:pedido_id, :motorista_id]
  end
end
