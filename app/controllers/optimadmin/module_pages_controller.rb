module Optimadmin
  class ModulePagesController < ApplicationController
    authorize_resource

    before_action :set_module_page, only: [:edit, :update, :destroy]

    # GET /module_pages
    # GET /module_pages.json
    def index
      @module_pages = ModulePage.all
    end

    # GET /module_pages/new
    def new
      @module_page = ModulePage.new
    end

    # GET /module_pages/1/edit
    def edit
    end

    # POST /module_pages
    # POST /module_pages.json
    def create
      @module_page = ModulePage.new(module_page_params)

      if @module_page.save
        respond_to do |format|
          format.html { redirect_to module_pages_url, notice: 'Module page was successfully created.' }
          format.js do
            @module_page = ModulePage.new
            flash[:notice] = 'Module page was successfully created.'
            render :success
            flash.clear
          end
        end
      else
        respond_to do |format|
          format.html { render :new }
          format.js
        end
      end
    end

    # PATCH/PUT /module_pages/1
    # PATCH/PUT /module_pages/1.json
    def update
      if @module_page.update(module_page_params)
        redirect_to module_pages_url, notice: 'Module page was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /module_pages/1
    # DELETE /module_pages/1.json
    def destroy
      @module_page.destroy
      redirect_to module_pages_url, notice: 'Module page was successfully destroyed.'
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_module_page
      @module_page = ModulePage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def module_page_params
      params.require(:module_page).permit(:name, :route)
    end
  end
end
