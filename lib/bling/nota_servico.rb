require 'httparty'

#
# Nota Serviço: Mantém notas de serviço

module Bling
  class BlingError < StandardError ; end

  class NotaServico
    include HTTParty

    base_uri "#{API_URL}"

    class << self

      # Salva uma nota de serviço
      #
      # Parâmetros:
      #
      # apikey - API Key obrigatória para requisiçãoes na plataforma Bling
      #
      # xml - Path para XML

      def salvar_nota_servico(attributes = {})
        apikey = attributes[:apikey]
        xml    = attributes[:xml]

        full_data = self.send(:post, '/notaservico/json', { query: { apikey: apikey, xml: xml } } )
        get_response(full_data["retorno"])
      end

      private

      def get_response data
        raise(BlingError, data["erros"]["erro"]) if data["erros"]
        data["notasservico"]
      end
    end
  end
end

