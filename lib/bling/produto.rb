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
      # xml - Path para XML

      def atualiza_produto(attributes = {})
        xml = attributes[:xml]

        full_data = self.send(:post, '/produto/json', { query: { apikey: Bling.apikey, xml: xml } } )
        full_data["retorno"]["produtos"]
      end

      # Deleta um produto
      #
      # Parâmetros:
      #
      # codigo - código do produto

      def deletar_produto(attributes = {})
        codigo = attributes[:codigo].to_s

        full_data = self.send(:delete, "/produto/#{codigo}", { body: { apikey: Bling.apikey } } )
        full_data["retorno"]["produtos"]["produto"]
      end

      # Busca por um produto
      #
      # Parâmetros:
      #
      # codigo - código do produto

      def produto(attributes = {})
        codigo = attributes[:codigo].to_s

        full_data = self.send(:get, "/produto/#{codigo}/json", { query: { apikey: Bling.apikey } } )
        full_data["retorno"]["produtos"]
      end

      # Listagem de produtos
      #
      # Parâmetros
      #
      # estoque - parâmetro para incluir estoque atual no retorno (opcional)
      #
      # page - parâmetro para paginação (opcional)

      def produtos(attributes = {})
        page_number = attributes[:page]
        page = "/page=#{page_number}" if page_number

        full_data = self.send(:get, "/produtos#{page}/json", { query: { apikey: Bling.apikey } } )
        full_data["retorno"]["produtos"]
      end

      # Salva um produto
      #
      # Parâmetros:
      #
      # xml - Path para XML

      def salvar_produto(attributes = {})
        xml = attributes[:xml]

        full_data = self.send(:post, '/produto/json', { query: { apikey: Bling.apikey, xml: xml } } )
        full_data["retorno"]["produtos"]
      end
    end
  end
end

