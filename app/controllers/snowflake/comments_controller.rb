module Snowflake
  class CommentsController < ApplicationController
    before_action :set_comment, only: [:show, :update, :destroy]

    # GET /comments
    def index
      @query_helper.update(model: Comment,
                           query: Comment.joins(:post).order("posts.title").to_sql,
                           search_fields: ["body"],
                           associations: [:post])

      render json: @query_helper.results
    end

    # GET /comments/1
    def show
      @query_helper.update(model: Comment,
                           query: Comment.where(id: params[:id]).to_sql,
                           single_record: true,
                           associations: [:post])

      render json: @query_helper.results
    end
  end
end
