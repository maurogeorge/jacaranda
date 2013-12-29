require "active_record"

I18n.load_path << File.join(File.dirname(__FILE__), "config", "locales", "en.yml")
warn '[deprecated] Jacaranda is deprecated. More info at http://groselhas.maurogeorge.com.br/good-bye-jacaranda-and-welcome-activerecord-enum.html'

module Jacaranda
  require "jacaranda/version"
  require "jacaranda/errors"
  require "jacaranda/base"
  require "jacaranda/predicate"
  require "jacaranda/scope"
end


ActiveRecord::Base.send(:include, Jacaranda)

