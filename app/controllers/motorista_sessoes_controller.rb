class MotoristaSessoesController < ApplicationController
  def new
    return unless motorista_logado?

    redirect_to motorista_painel_path, notice: "Você já está autenticado como motorista."
  end

  def create
    motorista = Motorista.find_by(email: params[:email].to_s.strip.downcase)

    if motorista&.authenticate(params[:password])
      session[:motorista_id] = motorista.id
      redirect_to motorista_painel_path, notice: "Login realizado com sucesso."
    else
      flash.now[:alert] = "E-mail ou senha inválidos."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:motorista_id)
    redirect_to root_path, notice: "Sessão encerrada com sucesso."
  end
end
