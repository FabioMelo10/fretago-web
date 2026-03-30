class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :motorista_atual, :motorista_logado?

  private

  def motorista_atual
    return @motorista_atual if defined?(@motorista_atual)

    @motorista_atual = Motorista.find_by(id: session[:motorista_id])
  end

  def motorista_logado?
    motorista_atual.present?
  end

  def autenticar_motorista!
    return if motorista_logado?

    redirect_to new_motorista_sessao_path, alert: "Faça login como motorista para acessar essa área."
  end
end
