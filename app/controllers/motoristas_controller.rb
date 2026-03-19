class MotoristasController < ApplicationController
  def new
    @motorista = Motorista.new
  end

  def create
    @motorista = Motorista.new(motorista_params.merge(ativo: true))

    if @motorista.save
      redirect_to root_path, notice: "Cadastro de motorista realizado com sucesso."
    else
      flash.now[:alert] = "Não foi possível concluir o cadastro. Confira os campos."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def motorista_params
    params.require(:motorista).permit(:nome, :telefone, :veiculo, :bairro)
  end
end

