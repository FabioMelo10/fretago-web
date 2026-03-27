class UpdatePedidoStatusToNewFlow < ActiveRecord::Migration[7.2]
  def up
    execute <<~SQL
      UPDATE pedidos
      SET status = CASE status
        WHEN 'aberto' THEN 'novo'
        WHEN 'aceito' THEN 'fechado'
        WHEN 'concluido' THEN 'fechado'
        ELSE status
      END
    SQL

    change_column_default :pedidos, :status, from: nil, to: "novo"
  end

  def down
    execute <<~SQL
      UPDATE pedidos
      SET status = CASE status
        WHEN 'novo' THEN 'aberto'
        WHEN 'fechado' THEN 'aceito'
        ELSE status
      END
    SQL

    change_column_default :pedidos, :status, from: "novo", to: nil
  end
end

