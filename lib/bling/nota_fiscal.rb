require 'httparty'

#
# Nota Fiscal: Mantém notas fiscais

module Bling
  class BlingError < StandardError ; end

  class NotaFiscal
    include HTTParty

    base_uri "#{API_URL}"

    class << self
      # Busca por uma nota fiscal através de numero e número de série
      #
      # Parâmetros:
      #
      # apikey - API Key obrigatória para requisiçãoes na plataforma Bling
      #
      # numero - (opcional)
      #
      # serie - (opcional)

      def nota_fiscal(attributes = {})
        apikey = attributes[:apikey]
        numero = attributes[:numero].to_s
        serie  = attributes[:serie].to_s

        full_data = self.send(:get, "/notafiscal/#{numero}/#{serie}/json", { query: { apikey: apikey } } )
        get_response(full_data["retorno"])
      end

      # Listagem de notas fiscais
      #
      # Parâmetros:
      #
      # apikey - API Key obrigatória para requisiçãoes na plataforma Bling
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
        apikey      = attributes[:apikey]
        page_number = attributes[:page]
        page        = "/page=#{page_number}" if page_number
        filters     = set_filters(attributes)

        full_data = self.send(:get, "/notasfiscais#{page}/json", { query: { apikey: apikey, filters: filters } } )
        get_response(full_data["retorno"])
      end

      # Salva uma nota fiscal
      #
      # Parâmetros:
      #
      # apikey - API Key obrigatória para requisiçãoes na plataforma Bling
      #
      # xml - Path para XML

      def salvar_nota_fiscal(attributes = {})
        apikey = attributes[:apikey]
        xml    = attributes[:xml]

        full_data = self.send(:post, '/notafiscal/json', { query: { apikey: apikey, xml: xml } } )
        get_response(full_data["retorno"])
      end

      # Salva e retorna os dados de uma nota fiscal
      #
      # Parâmetros:
      #
      # apikey - API Key obrigatória para requisiçãoes na plataforma Bling
      #
      # number - número da nota fiscal
      #
      # serie - número de série da nota fiscal
      #
      # send_mail - true/false (opcional)

      def salvar_consultar_nota_fiscal(attributes = {})
        apikey     = attributes[:apikey]
        number     = attributes[:number].to_s
        serie      = attributes[:serie].to_s
        send_email = attributes[:send_email]

        full_data = self.send(:post, '/notafiscal/json', { query: { apikey: apikey, number: number, serie: serie, sendEmail: send_email } } )
        get_response(full_data["retorno"])
      end

      private

      def get_response data
        raise(BlingError, data["erros"]["erro"]) if data["erros"]
        data["notasservico"]
      end

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

