module ActionView
  module Helpers
    class FormBuilder

      def image_field(method, options = {})
        @template.render 'optimadmin/shared/image_field', f: self, image: method, options: options
      end

      def document_field(method)
        @template.render 'optimadmin/shared/document_field', f: self, document: method
      end

      def datepicker_field(method)
        @template.render 'optimadmin/shared/datepicker_field', f: self, date: method
      end

      def datetimepicker_field(method)
        @template.render 'optimadmin/shared/datetimepicker_field', f: self, date: method
      end
    end
  end
end
