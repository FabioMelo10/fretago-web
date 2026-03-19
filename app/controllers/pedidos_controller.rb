class PedidosController < ApplicationController
  before_action :set_pedido, only: %i[show aceitar_proposta]

  def index
    @pedidos = Pedido.where(status: "aberto").order(created_at: :desc)
  end

  def show
    @proposta = Proposta.new
    @propostas = @pedido.propostas.includes(:motorista).order(created_at: :desc)
  end

  def new
    @pedido = Pedido.new
  end

  def create
    @pedido = Pedido.new(pedido_params.merge(status: "aberto"))

    if @pedido.save
      redirect_to @pedido, notice: "Seu pedido de frete foi criado com sucesso."
    else
      flash.now[:alert] = "Não foi possível criar o pedido. Confira os campos."
      render :new, status: :unprocessable_entity
    end
  end

  def aceitar_proposta
    proposta = @pedido.propostas.find(params[:proposta_id])

    Pedido.transaction do
      @pedido.propostas.where.not(id: proposta.id).update_all(status: "recusada")
      proposta.update!(status: "aceita")
      @pedido.update!(status: "aceito")
    end

    redirect_to @pedido, notice: "Proposta aceita com sucesso. Combinem os detalhes pelo WhatsApp."
  rescue ActiveRecord::RecordInvalid, ActiveRecord::RecordNotFound
    redirect_to @pedido, alert: "Não foi possível aceitar esta proposta."
  end

  private

  def set_pedido
    @pedido = Pedido.find(params[:id])
  end

  def pedido_params
    params.require(:pedido).permit(:nome_cliente, :telefone, :endereco_retirada, :endereco_entrega, :item, :detalhes)
  end
end

