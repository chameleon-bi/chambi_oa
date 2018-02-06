module Optimadmin
  class DocumentsController < Optimadmin::ApplicationController
    def index
      respond_to do |format|
        format.html { @documents = Document.where('name ILIKE ?', "%#{params[:search]}%").page(params[:page]).per(params[:per_page] || 25).order(params[:order]) }
        format.js do
          @documents = Document.order('name')
          render layout: nil
        end
      end
    end

    def new
      @document = Document.new
    end

    def create
      @document = Document.new(document_params)
      if @document.save
        flash[:notice] = 'Successfully created document.'
        redirect_to documents_path
      else
        render action: 'new'
      end
    end

    def edit
      @document = Document.find(params[:id])
    end

    def update
      @document = Document.find(params[:id])
      if @document.update_attributes(document_params)
        redirect_to documents_path, flash: { notice: 'Successfully updated document.' }
      else
        render action: 'edit'
      end
    end

    def destroy
      @document = Document.find(params[:id])
      @document.destroy
      redirect_to documents_path, flash: { notice: 'Successfully destroyed document.' }
    end

    def update_collection
      @document_collection = Optimadmin::Document.page(params[:page]).per(6)
      @document_name = params[:document]
      respond_to do |format|
        format.js { render 'optimadmin/documents/update_collection' }
      end
    end

    def upload
      @document = Document.new(document_params)
      @saved = if @document.save
                 true
               else
                 false
               end
      render layout: nil
    end

    def new_inline
      @document = Document.new
      render layout: nil
    end

    def create_inline
      @document = Document.new(document_params)
      if @document.save
        render action: 'close', layout: nil
      else
        render action: 'new_inline', layout: nil
      end
    end

    private

    def document_params
      params.require(:document).permit!
    end
  end
end
