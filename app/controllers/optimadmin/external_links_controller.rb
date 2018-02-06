module Optimadmin
  class ExternalLinksController < ApplicationController
    load_and_authorize_resource

    before_action :set_external_link, only: [:edit, :update, :destroy]

    # GET /external_links
    # GET /external_links.json
    def index
      @external_links = ExternalLink.all
    end

    # GET /external_links/new
    def new
      @external_link = ExternalLink.new
    end

    # GET /external_links/1/edit
    def edit
    end

    # POST /external_links
    # POST /external_links.json
    def create
      @external_link = ExternalLink.new(external_link_params)
      if @external_link.save
        respond_to do |format|
          format.html { redirect_to external_links_url, notice: 'External link was successfully created.' }
          format.js do
            @external_link = ExternalLink.new
            flash[:notice] = 'External link was successfully created.'
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

    # PATCH/PUT /external_links/1
    # PATCH/PUT /external_links/1.json
    def update
      if @external_link.update(external_link_params)
        respond_to do |format|
          format.html { redirect_to external_links_url, notice: 'External link was successfully updated.' }
          format.js do
            @external_link = ExternalLink.new
            flash[:notice] = 'External link was successfully updated.'
            render :success
            flash.clear
          end
        end
      else
        respond_to do |format|
          format.html { render :edit }
          format.js
        end
      end
    end

    # DELETE /external_links/1
    # DELETE /external_links/1.json
    def destroy
      @external_link.destroy
      redirect_to external_links_url, notice: 'External link was successfully destroyed.'
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_external_link
      @external_link = ExternalLink.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def external_link_params
      params.require(:external_link).permit(:name)
    end
  end
end
