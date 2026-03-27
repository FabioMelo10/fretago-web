class PedidoNotifier
  def self.notify_new_pedido(pedido)
    Rails.logger.info(
      "[FRETAGO][NOVO_PEDIDO] id=#{pedido.id} origem=#{pedido.endereco_retirada} destino=#{pedido.endereco_entrega} item=#{pedido.item}"
    )
  end
end

