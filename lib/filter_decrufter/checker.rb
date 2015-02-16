module FilterDecrufter

  class Report

    attr_accessor :controller_to_filter_collection

    def self.instance
      @instance ||= Report.new
    end

    def initialize
     @controller_to_filter_collection = {}
    end

    def add(controller_class, before_filter_name, options)
       # TODO could use some data structure vs Hash of hashes
       before_filter_options = controller_to_filter_collection[controller_class] ||= {}
       before_filter_options[before_filter_name] = options
       raise "Oops filter_decrufter can't handle this version of Rails" unless controller_class.respond_to?(:action_methods)
    end

    def find_problems
      controller_to_filter_collection.each do |controller_class, before_filter_to_options_map|
        action_methods = controller_class.action_methods.map &:to_sym
        before_filter_to_options_map.each do |filter_name, opts|
          populated_only_except = opts.select {|opt_name,opt_value| [:only,:except].include?(opt_name) && !opt_value.empty? }
          [:only, :except].each do |constraint_name|
            check_constraint(constraint_name, action_methods, populated_only_except, controller_class, filter_name) if populated_only_except[constraint_name].present?
          end
        end
      end
    end

    def check_constraint(name, action_methods, populated_only_except, controller_class, filter_name)
      [populated_only_except[name]].flatten.each do |action_syms|
        [action_syms].flatten.each do |action_to_filter|
          if !action_methods.include?(action_to_filter)
            puts "#{controller_class} before_filter #{filter_name} has an :#{name} constraint with a non-existent action name #{action_to_filter}"
          end
        end
      end
    end

  end

  class Checker

    def initialize
      raise "This is a Rails utility" unless defined?(Rails)
      raise "Oops filter_decrufter can't handle this version of Rails" unless Rails.respond_to?(:application)
    end

    def check
      [:before_filter, :around_filter, :after_filter].each {|s| patch_method(s) }
      load_all_controllers
      show_report
      nil
    end

    private

    def show_report
      Report.instance.find_problems
    end

    def patch_method(filter_sym)
      ApplicationController.define_singleton_method(filter_sym) do |*args, &blk|
        if args.many? && (args[1][:only].present? || args[1][:except].present?)
          Report.instance.add(self, args[0], args[1])
        end
        super(*args, &blk)
      end
    end

    def load_all_controllers
      Rails.application.eager_load!
    end

  end
end
