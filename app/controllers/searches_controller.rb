# coding: utf-8
class SearchesController < ApplicationController
  def index
    mquery = params[:query].present? ? params[:query] : '*'
    @searches = Elasticsearch::Model.search(
      query: { 
       multi_match: {
        query:  mquery, 
        fields: [ "title^3", "body" ] 
       }
      })#,
      #highlight: { fields: { body: {} } })
  end
end



