require "rubygems"
require 'active_support/core_ext/module/attribute_accessors'
require 'active_support/deprecation'

#
# Base: Configurações gerais e métodos que são utilizados em mais de uma classe

module Bling
  extend self

  # URL padrão para requisições no servidor Bling
  API_URL = "https://bling.com.br/Api/v2"
end

class Object
  def blank?
    respond_to?(:empty?) ? empty? : !self
  end
end

