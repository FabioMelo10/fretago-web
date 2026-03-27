module ApplicationHelper
  def fregato_whatsapp_link
    number = ENV.fetch("FRETAGO_WHATSAPP_NUMBER", "5547999999999")
    message = <<~MSG
      Olá! Vim pelo FretaGo e preciso de um frete.

      Origem:
      Destino:
      Item:
      Horário:

      Pode me ajudar com um orçamento?
    MSG

    whatsapp_link_with_message(message)
  end

  def pedido_whatsapp_link(pedido)
    if pedido.endereco_retirada.present? && pedido.endereco_entrega.present? && pedido.item.present?
      message = <<~MSG
        Olá! Vim pelo FretaGo e já enviei um pedido:

        Origem: #{pedido.endereco_retirada}
        Destino: #{pedido.endereco_entrega}
        Item: #{pedido.item}

        Pode me ajudar com um orçamento?
      MSG
      whatsapp_link_with_message(message)
    else
      fregato_whatsapp_link
    end
  end

  def pedido_status_badge_class(status)
    case status
    when "novo" then "bg-slate-700 text-slate-100"
    when "em_negociacao" then "bg-amber-500/20 text-amber-300"
    when "fechado" then "bg-emerald-500/20 text-emerald-300"
    when "cancelado" then "bg-rose-500/20 text-rose-300"
    else "bg-slate-800 text-slate-300"
    end
  end

  private

  def whatsapp_link_with_message(message)
    number = ENV.fetch("FRETAGO_WHATSAPP_NUMBER", "5547999999999")
    "https://wa.me/#{number}?text=#{ERB::Util.url_encode(message)}"
  end
end

