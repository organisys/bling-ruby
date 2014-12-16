require 'httparty'

#
# Nota Serviço: Mantém notas de serviço

module Bling
  class NotaServico
    include HTTParty

    base_uri "#{API_URL}"

    class << self

      # Salva uma nota de serviço
      #
      # Parâmetros:
      #
      # xml - Path para XML

      def salvar_nota_servico(attributes = {})
        xml = attributes[:xml]

        full_data = self.send(:post, '/notaservico/json', { query: { apikey: Bling.apikey, xml: xml } } )
        full_data["retorno"]["notasservico"]
      end
    end
  end
end

