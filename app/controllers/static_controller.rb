class StaticController < ApplicationController
  def page
    render ( params[ :page_name ] || 'not_found' )
  end
end
