require 'httparty'

#
# Pedido: Mantém pedidos

module Bling
  class BlingError < StandardError ; end

  class Pedido
    include HTTParty

    base_uri "#{API_URL}"

    class << self

      # Busca por um pedido
      #
      # Parâmetros:
      #
      # apikey - API Key obrigatória para requisiçãoes na plataforma Bling
      #
      # xml - Path para XML

      def pedido(attributes = {})
        apikey = attributes[:apikey]
        numero = attributes[:numero].to_s

        full_data = self.send(:get, "/pedido/#{numero}/json", { query: { apikey: apikey } } )
        get_response(full_data["retorno"])
      end

      # Lista pedidos do sistema
      #
      # Parâmetros:
      #
      # apikey - API Key obrigatória para requisiçãoes na plataforma Bling
      #
      # page - parâmetro para paginação (opcional)

      def pedidos(attributes = {})
        apikey      = attributes[:apikey]
        page_number = attributes[:page]
        page        = "/page=#{page_number}" if page_number

        full_data = self.send(:get, "/pedidos#{page}/json", { query: { apikey: apikey } } )
        get_response(full_data["retorno"])
      end

      # Salva um pedido
      #
      # Parâmetros:
      #
      # apikey - API Key obrigatória para requisiçãoes na plataforma Bling
      #
      # xml - Path para XML
      #
      # gera_nfe - true/false (opcional)

      def salvar_pedido(attributes = {})
        apikey    = attributes[:apikey]
        xml       = attributes[:xml]
        gerar_nfe = attributes[:gerar_nfe].to_s

        full_data = self.send(:post, "/pedido/json", { query: { apikey: apikey, xml: xml, gerarnfe: gerar_nfe } } )
        get_response(full_data["retorno"])
      end

      private

      def get_response data
        raise(BlingError, data["erros"]["erro"]) if data["erros"]
        data["pedidos"]
      end
    end
  end
end

