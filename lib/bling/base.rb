require "rubygems"
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/deprecation'

#
# Base: Configurações gerais e métodos que são utilizados em mais de uma classe

module Bling
  extend self

  # URL padrão para requisições no servidor Bling
  API_URL = "https://bling.com.br/Api/v2"

  # Variável que contém API Key
  mattr_accessor :apikey

  # Carrega arquivo de inicialização com configurações gerais
  def self.setup
    yield self
  end

  def show_data(param)
    if param["erros"]
      if param["erros"]["cod"] == 14
        []
      end
    else
      param
    end
  end

  class MissingApiKeyError < StandardError; end
end

class Object
  def blank?
    respond_to?(:empty?) ? empty? : !self
  end
end

