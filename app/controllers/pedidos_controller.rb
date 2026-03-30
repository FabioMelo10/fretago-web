class PedidosController < ApplicationController
  before_action :set_pedido, only: %i[show aceitar_proposta sucesso atualizar_status]
  before_action :autenticar_motorista!, only: %i[index show aceitar_proposta atualizar_status]

  def index
    redirect_to motorista_painel_path
  end

  def show
    @proposta = Proposta.new
    @propostas = @pedido.propostas.includes(:motorista).order(created_at: :desc)
  end

  def new
    @pedido = Pedido.new
  end

  def create
    if spam_submission?
      redirect_to new_pedido_path, alert: "Não foi possível processar seu pedido."
      return
    end

    if rate_limited?
      redirect_to new_pedido_path, alert: "Muitas tentativas. Aguarde um minuto e tente novamente."
      return
    end

    @pedido = Pedido.new(pedido_params)

    if @pedido.save
      PedidoNotifier.notify_new_pedido(@pedido)
      redirect_to sucesso_pedido_path(@pedido), notice: "Seu pedido de frete foi criado com sucesso."
    else
      flash.now[:alert] = "Não foi possível criar o pedido. Confira os campos."
      render :new, status: :unprocessable_entity
    end
  end

  def sucesso
  end

  def atualizar_status
    novo_status = params[:status].to_s
    unless Pedido.statuses.key?(novo_status)
      redirect_to pedidos_path, alert: "Status inválido."
      return
    end

    @pedido.update!(status: novo_status)
    redirect_to pedidos_path, notice: "Status atualizado para #{novo_status.humanize}."
  rescue ActiveRecord::RecordInvalid
    redirect_to pedidos_path, alert: "Não foi possível atualizar o status."
  end

  def aceitar_proposta
    proposta = @pedido.propostas.find(params[:proposta_id])

    Pedido.transaction do
      @pedido.propostas.where.not(id: proposta.id).update_all(status: "recusada")
      proposta.update!(status: "aceita")
      @pedido.update!(status: "fechado")
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
    params.require(:pedido).permit(:nome_cliente, :telefone, :endereco_retirada, :endereco_entrega, :item, :detalhes, :status)
  end

  def spam_submission?
    params.dig(:pedido, :website).present?
  end

  def rate_limited?
    key = "pedido_create:#{request.remote_ip}"
    count = Rails.cache.read(key).to_i
    return true if count >= 5

    Rails.cache.write(key, count + 1, expires_in: 1.minute)
    false
  end
end
