#/lib/GramAccount.rb
#!/bin/env ruby
# encoding: utf-8


# exemple pour rechercher avec un idSoce
#GramSearch.where(:idSoce => "84185")


require 'active_resource'
class GramSearch < ActiveResource::Base
  self.element_name = "search"
  self.collection_name = "search/uniq"
  self.site = AppConfig.value_at('gram_api_host')
  self.user = AppConfig.value_at('gram_api_user')
  self.password = AppConfig.value_at('gram_api_password')
  self.proxy = AppConfig.value_at('gram_api_proxy') if AppConfig.value_at('gram_api_proxy')


  #Overwrite find_single from ActiveResource::Base to be able to use gram api (/accounts suffix)
  #https://github.com/rails/activeresource/blob/master/lib/active_resource/base.rb#L991
  def self.element_path(id, prefix_options = {}, query_options = nil)
     #query_options = "uniq.json?idSoce=" + id
     id = "uniq"
     super(id, prefix_options, query_options)
  end

  def collection_path(prefix_options = {}, query_options = nil)
    id = "uniq"
    super(id, prefix_options, query_options)
  end

  #Overwrite to_param from ActiveResource::Base to be able to use gram api (id = hruid)
  #https://github.com/rails/activeresource/blob/master/lib/active_resource/base.rb#L991
  def to_param
    self.hruid
  end

end