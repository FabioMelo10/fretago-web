class PropostasController < ApplicationController
  before_action :set_pedido
  before_action :autenticar_motorista!

  def new
    @proposta = @pedido.propostas.new
  end

  def create
    @proposta = @pedido.propostas.new(proposta_params)

    if @proposta.save
      @pedido.update(status: "em_negociacao") if @pedido.novo?
      redirect_to @pedido, notice: "Proposta enviada com sucesso."
    else
      @propostas = @pedido.propostas.includes(:motorista).order(created_at: :desc)
      flash.now[:alert] = "Não foi possível enviar a proposta. Confira os campos."
      render "pedidos/show", status: :unprocessable_entity
    end
  end

  private

  def set_pedido
    @pedido = Pedido.find(params[:pedido_id])
  end

  def proposta_params
    params.require(:proposta).permit(:valor, :mensagem).merge(status: "enviada", motorista: motorista_atual)
  end
end
