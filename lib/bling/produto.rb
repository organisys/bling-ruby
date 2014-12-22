require 'httparty'

#
# Produto: Mantém produtos

module Bling
  class Produto
    include HTTParty

    base_uri "#{API_URL}"

    class << self

      #
      # Atualiza um produto
      #
      # Parâmetros:
      #
      # apikey - API Key obrigatória para requisiçãoes na plataforma Bling
      #
      # xml - Path para XML

      def atualiza_produto(attributes = {})
        apikey = attributes[:apikey]
        xml    = attributes[:xml]

        full_data = self.send(:post, '/produto/json', { query: { apikey: apikey, xml: xml } } )
        full_data["retorno"]["produtos"]
      end

      # Deleta um produto
      #
      # Parâmetros:
      #
      # apikey - API Key obrigatória para requisiçãoes na plataforma Bling
      #
      # codigo - código do produto

      def deletar_produto(attributes = {})
        apikey = attributes[:apikey]
        codigo = attributes[:codigo].to_s

        full_data = self.send(:delete, "/produto/#{codigo}", { body: { apikey: apikey } } )
        full_data["retorno"]["produtos"]["produto"]
      end

      # Busca por um produto
      #
      # Parâmetros:
      #
      # apikey - API Key obrigatória para requisiçãoes na plataforma Bling
      #
      # codigo - código do produto

      def produto(attributes = {})
        apikey = attributes[:apikey]
        codigo = attributes[:codigo].to_s

        full_data = self.send(:get, "/produto/#{codigo}/json", { query: { apikey: apikey } } )
        full_data["retorno"]["produtos"]
      end

      # Listagem de produtos
      #
      # Parâmetros
      #
      # apikey - API Key obrigatória para requisiçãoes na plataforma Bling
      #
      # estoque - parâmetro para incluir estoque atual no retorno (opcional)
      #
      # page - parâmetro para paginação (opcional)

      def produtos(attributes = {})
        apikey      = attributes[:apikey]
        page_number = attributes[:page]
        page        = "/page=#{page_number}" if page_number

        full_data = self.send(:get, "/produtos#{page}/json", { query: { apikey: apikey } } )
        full_data["retorno"]["produtos"]
      end

      # Salva um produto
      #
      # Parâmetros:
      #
      # apikey - API Key obrigatória para requisiçãoes na plataforma Bling
      #
      # xml - Path para XML

      def salvar_produto(attributes = {})
        apikey = attributes[:apikey]
        xml    = attributes[:xml]

        full_data = self.send(:post, '/produto/json', { query: { apikey: apikey, xml: xml } } )
        full_data["retorno"]["produtos"]
      end
    end
  end
end

