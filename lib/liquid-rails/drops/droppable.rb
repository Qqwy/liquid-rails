module Liquid
  module Rails
    module Droppable
      extend ActiveSupport::Concern

      def to_liquid
        drop_class.new(self)
      end
      alias_method :dropify, :to_liquid

      def drop_class
        self.class.drop_class
      end

      module ClassMethods
        #Tries to construct ModelNameDrop from ModelName
        #And if it could not be found, attempts its parent class, so polymorphism is supported.
        def drop_class
          class_name = self.name
          while class_name != "Object"
            begin
              drop_class = "#{class_name}Drop".constantize
              return drop_class
            rescue NameError => e
              class_name = class_name.parent
            end
          end
        end
      end
    end
  end
end
