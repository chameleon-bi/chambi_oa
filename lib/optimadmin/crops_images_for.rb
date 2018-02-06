module Optimadmin
  module CropsImagesFor
    def self.included(base)
      base.extend(BaseMethods)
    end

    class Initializer
      attr_reader :klass, :image_names

      def initialize(in_model, image_names)
        @klass = in_model
        @image_names = image_names
      end
    end

    module BaseMethods
      def edit_images_for(in_model, image_names)
        @initializer = Optimadmin::CropsImagesFor::Initializer.new(in_model, image_names)
        send :include, Optimadmin::CropsImagesFor::ClassMethods
      end

      def edit_image_for(in_model, image_name)
        edit_images_for(in_model, [image_name])
      end

      # This method is in for backwards compatibility and will be removed at some point - 13/2/2013
      def crops_images_for(in_model, image_name, options = {})
        if options.blank?
          edit_images_for(in_model, [image_name])
        else
          new_options = {}
          options.each_pair do |key, value|
            if value.class == String
              new_options[key] = [value]
            elsif value.class == Hash
              new_options[key] = [value.keys.first.to_s] + value.values.first
            end
          end
          edit_images_for(in_model, [[image_name, new_options]])
        end
      end

      def initializer
        @initializer || superclass.instance_variable_get('@initializer')
      end
    end

    module ClassMethods
      def edit_images
        klass = self.class.initializer.klass
        klass_instance = klass.find(params[:id])

        @image_names = []
        @image_options = {}

        self.class.initializer.image_names.each do |image_name|
          if image_name.class == Array
            if klass_instance.send("#{image_name.first}?")
              @image_names << image_name.first.to_s
              @image_options[image_name.first.to_s] = image_name.last
            end
          else
            @image_names << image_name.to_s
          end
        end

        @module = klass_instance
        @image_name = (crop_images_params[:image_name] || @image_names.first)
        @current_image = klass_instance.send(@image_name)
        @current_image_file = MiniMagick::Image.open(@current_image.path)

        @current_image_versions = {}
        @current_image.versions.each do |version|
          asset_host = Rails.application.config.asset_host
          path = asset_host.blank? ? version.last : version.last.to_s.sub(asset_host, '')

          if File.exist?("#{Rails.root}/public#{path}")
            @current_image_versions[version.first] = MiniMagick::Image.open("#{Rails.root}/public#{path}")
          end
        end

        render 'optimadmin/crops_images_for/edit_images'
      end

      def update_image_default
        get_update_variables
        version_file = MiniMagick::Image.open(@current_image.send(@key).path)

        @current_image_file.crop("#{crop_images_params[@key][:width]}x#{crop_images_params[@key][:height]}+#{crop_images_params[@key][:x1]}+#{crop_images_params[@key][:y1]}")

        @current_image_file.resize("#{version_file[:width]}x#{version_file[:height]}")
        @current_image_file.write(@current_image.send(crop_images_params[:key]).path)

        unless @skip_render == true
          respond_to do |format|
            format.js { render 'optimadmin/crops_images_for/update_images' }
            format.html { rerender_edit_images }
          end
        end
      end

      def update_image_fill
        get_update_variables
        version_file = MiniMagick::Image.open(@current_image.send(@key).path)

        @current_image_file.crop("#{crop_images_params[@key][:width]}x#{crop_images_params[@key][:height]}+#{crop_images_params[@key][:x1]}+#{crop_images_params[@key][:y1]}")

        @current_image_file.combine_options do |img|
          if crop_images_params[@key][:width].to_i > version_file[:width] || crop_images_params[@key][:height].to_i > version_file[:height]
            img.resize "#{version_file[:width]}x#{version_file[:height]}"
          end
          img.background crop_images_params[@key][:background_colour]
          img.gravity 'Center'
          img.extent("#{version_file[:width]}x#{version_file[:height]}")
        end
        @current_image_file.write(@current_image.send(crop_images_params[:key]).path)

        unless @skip_render == true
          respond_to do |format|
            format.js { render 'optimadmin/crops_images_for/update_images' }
            format.html { rerender_edit_images }
          end
        end
      end

      def update_image_fit
        get_update_variables

        dimensions = @image_options[@image_name][@key.to_sym][1..2]
        @current_image_file.crop("#{crop_images_params[@key][:width]}x#{crop_images_params[@key][:height]}+#{crop_images_params[@key][:x1]}+#{crop_images_params[@key][:y1]}")
        if crop_images_params[@key][:width].to_i > dimensions.first || crop_images_params[@key][:height].to_i > dimensions.last
          @current_image_file.resize("#{dimensions.first}x#{dimensions.last}")
        end
        @current_image_file.write(@current_image.send(crop_images_params[:key]).path)

        unless @skip_render == true
          respond_to do |format|
            format.js { render 'optimadmin/crops_images_for/update_images' }
            format.html { rerender_edit_images }
          end
        end
      end

      private

      def crop_images_params
        params.permit!
      end

      def get_update_variables
        klass = self.class.initializer.klass
        klass_instance = klass.find(params[:id])
        @image_names = []
        @image_options = {}
        self.class.initializer.image_names.each do |image_name|
          if image_name.class == Array
            @image_names << image_name.first.to_s
            @image_options[image_name.first.to_s] = image_name.last
          else
            @image_names << image_name.to_s
          end
        end

        @image_name = (params[:image_name] || @image_names.first)
        @current_image = klass_instance.send(@image_name)
        @key = params[:key]

        @current_image_file = MiniMagick::Image.open(@current_image.path)
      end

      def rerender_edit_images
        @current_image_file = MiniMagick::Image.open(@current_image.path)

        @current_image_versions = {}
        @current_image.versions.each do |version|
          if File.exist?("#{Rails.root}/public#{version.last}")
            @current_image_versions[version.first] = MiniMagick::Image.open("#{Rails.root}/public#{version.last}")
          end
        end

        render 'optimadmin/crops_images_for/edit_images' # , :layout => 'manticore/application_no_left_nav'
      end
    end
  end
end
