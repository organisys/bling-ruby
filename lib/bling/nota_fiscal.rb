require 'httparty'

#
# Nota Fiscal: Mantém notas fiscais

module Bling
  class NotaFiscal
    include HTTParty

    base_uri "#{API_URL}"

    class << self
      # Busca por uma nota fiscal através de numero e número de série
      #
      # Parâmetros:
      #
      # numero - (opcional)
      #
      # serie - (opcional)

      def nota_fiscal(attributes = {})
        numero = attributes[:numero].to_s
        serie  = attributes[:serie].to_s

        full_data = self.send(:get, "/notafiscal/#{numero}/#{serie}/json", { query: { apikey: Bling.apikey } } )
        full_data["retorno"]["notasfiscais"]
      end

      # Listagem de notas fiscais
      #
      # Parâmetros:
      #
      # page - parâmetro para paginação (opcional)
      #
      # data_emissao - filtro para data de emissão da nota fiscal (opcional)
      #
      # data_emissao_from - filtro para data de emissão da nota fiscal (opcional)
      #
      # data_emissao_to - para data de emissão da nota fiscal (deve ser utilizado sempre com o atributo 'data_emissao_from') (opcional)
      #
      # situacao - veja em [http://bling.com.br/manuais.bling.php?p=manuais.api2#getNotasFiscais] as possíveis situações (opcional)

      def notas_fiscais(attributes = {})
        page_number = attributes[:page]
        page = "/page=#{page_number}" if page_number

        filters = set_filters(attributes)

        full_data = self.send(:get, "/notasfiscais#{page}/json", { query: { apikey: Bling.apikey, filters: filters } } )

        show_data(full_data["retorno"])
      end

      # Salva uma nota fiscal
      #
      # Parâmetros:
      #
      # xml - Path para XML

      def salvar_nota_fiscal(attributes = {})
        xml = attributes[:xml]

        full_data = self.send(:post, '/notafiscal/json', { query: { apikey: Bling.apikey, xml: xml } } )
        full_data["retorno"]["notasfiscais"]
      end

      # Salva e retorna os dados de uma nota fiscal
      #
      # Parâmetros:
      #
      # number - número da nota fiscal
      #
      # serie - número de série da nota fiscal
      #
      # send_mail - true/false (opcional)

      def salvar_consultar_nota_fiscal(attributes = {})
        number     = attributes[:number].to_s
        serie      = attributes[:serie].to_s
        send_email = attributes[:send_email]

        full_data = self.send(:post, '/notafiscal/json', { query: { apikey: Bling.apikey, number: number, serie: serie, sendEmail: send_email } } )
        full_data["retorno"]["notasfiscais"]
      end

      private

      def set_filters attributes
        data_emissao_from = attributes[:data_emissao_from]
        data_emissao_to   = attributes[:data_emissao_to]
        situacao          = attributes[:situacao]
        filters           = ""

        if data_emissao_from && data_emissao_to
          filters << "dataEmissao[#{data_emissao_from} TO #{data_emissao_to}]"
        end

        filters << ";" if filters.match(/dataEmissao/) && situacao
        filters << "situacao[#{situacao}]" if situacao
        filters
      end
    end
  end
end

