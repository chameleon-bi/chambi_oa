module Optimadmin
  class ImagesController < Optimadmin::ApplicationController
    crops_images_for Optimadmin::Image, :image

    def index
      respond_to do |format|
        format.html { @images = Image.where('name ILIKE ?', "%#{params[:search]}%").order(params[:order]).page(params[:page]).per(params[:per_page] || 25) }
        format.js do
          @images = Image.order('name')
          render layout: nil
        end
      end
    end

    def new
      @image = Image.new
    end

    def create
      @image = Image.new(image_params)
      if @image.save
        redirect_to images_path, flash: { notice: 'Successfully created image.' }
      else
        render action: 'new'
      end
    end

    def edit
      @image = Image.find(params[:id])
    end

    def update
      @image = Image.find(params[:id])
      if @image.update_attributes(image_params)
        redirect_to images_path, flash: { notice: 'Successfully updated image.' }
      else
        render action: 'edit'
      end
    end

    def destroy
      @image = Image.find(params[:id])
      @image.destroy
      redirect_to images_path, flash: { notice: 'Successfully destroyed image.' }
    end

    def update_collection
      @image_collection = Optimadmin::Image.page(params[:page]).per(6)
      @image_name = params[:image]
      respond_to do |format|
        format.js { render 'optimadmin/images/update_collection' }
      end
    end

    def upload
      @image = Image.new(image_params)
      @saved = if @image.save
                 true
               else
                 false
               end
      render layout: nil
    end

    def new_inline
      @image = Image.new
      render layout: nil
    end

    def create_inline
      @image = Image.new(image_params)
      if @image.save
        render action: 'close', layout: nil
      else
        render action: 'new_inline', layout: nil
      end
    end

    def tinymce
      @images = Image.search(params[:image_name])
      respond_to do |format|
        format.html { render layout: nil }
        format.js { render layout: nil }
      end
    end

    private

    def image_params
      params.fetch(:image, {}).permit!
    end
  end
end
