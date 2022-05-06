module Snowflake
  class PostsController < ApplicationController
    before_action :set_post, only: [:show, :update, :destroy]

    # GET /posts
    def index
      @query_helper.update(model: Post,
                           query: Post.order(:title).to_sql,
                           search_fields: ['title'],
                           associations: [:comments])

      render json: @query_helper.results
    end

    # GET /posts/1
    def show
      @query_helper.update(model: Post,
                           query: Post.where(id: params[:id]).to_sql,
                           single_record: true,
                           associations: [:comments])

      render json: @query_helper.results
    end
  end
end
