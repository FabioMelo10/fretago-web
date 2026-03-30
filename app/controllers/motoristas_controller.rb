class MotoristasController < ApplicationController
  def new
    if motorista_logado?
      redirect_to motorista_painel_path, notice: "Você já possui sessão ativa."
      return
    end

    @motorista = Motorista.new
  end

  def create
    @motorista = Motorista.new
    @motorista.assign_attributes(motorista_params.merge(ativo: true))

    if @motorista.save
      session[:motorista_id] = @motorista.id
      redirect_to motorista_painel_path, notice: "Cadastro de motorista realizado com sucesso."
    else
      flash.now[:alert] = "Não foi possível concluir o cadastro. Confira os campos."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def motorista_params
    params.require(:motorista).permit(
      :nome,
      :telefone,
      :email,
      :cpf,
      :renavam,
      :placa_veiculo,
      :tipo_veiculo,
      :modelo_veiculo,
      :ano_veiculo,
      :cidade_atuacao,
      :password,
      :password_confirmation
    )
  end
end
