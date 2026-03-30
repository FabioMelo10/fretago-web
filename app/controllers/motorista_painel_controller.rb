class MotoristaPainelController < ApplicationController
  before_action :autenticar_motorista!

  def show
    @pedidos = Pedido.disponiveis_para_motoristas.order(created_at: :desc)
  end
end
