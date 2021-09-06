class TagsController < ApplicationController

  # GET /tags
  def show
    tags = Tag.all
    render json: tags, root: 'tags', adapter: :json, each_serializer: TagSerializer
  end

  # GET /tags/:tag
  def search
    tag = params[:tag]
    
    if tag_exists?(tag)
      tags = Tag.where(title: tag)
      render json: tags, root: 'tags', adapter: :json, each_serializer: TagSerializer
    else
      render json: { "Error": "A tag '#{tag}' não foi encontrada." }, status: :not_found
    end
    
  end

  # DELETE /tags/:tag
  def remove
    tag = params[:tag]
    
    if tag_exists?(tag)
      Tag.delete_all(title: tag)
      render json: Tag.all, root: 'tags', adapter: :json, each_serializer: TagSerializer
    else
      render json: { "Error": "A tag '#{tag}' não foi encontrada." }, status: :not_found
    end
  end

  # DELETE /clean/tags
  def clean
    Tag.delete_all
    render json: { Success: "Todas as tags foram removidas." }
  end

  private
    def tag_exists?(tag)
      Tag.where(title: tag).count > 0 ? true : false
    end
end
