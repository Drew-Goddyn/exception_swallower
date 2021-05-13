module ExceptionSwallower

  def self.included(klass)
    klass.extend(ClassMethods)
  end

  module ClassMethods
    def swallow_exceptions(*exceptions)
      self.singleton_class.instance_variable_set("@swallowed_exceptions", exceptions)
    end

    def singleton_method_added(method_name)
      super
      handle_class_method_exceptions(method_name) unless @ignoring_added_methods
    end

    def method_added(method_name)
      super
      handle_instance_method_exceptions(method_name) unless @ignoring_added_methods
    end

    def handle_class_method_exceptions(method_name)
      swallowed_exceptions = self.singleton_class.instance_variable_get("@swallowed_exceptions")
      return if swallowed_exceptions.nil?

      old_method = method(method_name)
      @ignoring_added_methods = true
      define_singleton_method(method_name) do |*args, &block|
        begin
          old_method.call(*args, &block)
        rescue *swallowed_exceptions; end
      end

      @ignoring_added_methods = false
    end

    def handle_instance_method_exceptions(method_name)
      swallowed_exceptions = self.singleton_class.instance_variable_get("@swallowed_exceptions")
      return if swallowed_exceptions.nil?

      old_method = instance_method(method_name)
      @ignoring_added_methods = true
      define_method(method_name) do |*args, &block|
        begin
          old_method.bind(self).call(*args, &block)
        rescue *swallowed_exceptions; end
      end

      @ignoring_added_methods = false
    end
  end
end
