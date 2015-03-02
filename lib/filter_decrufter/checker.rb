module FilterDecrufter

  class Hit

    attr_accessor :controller_class, :filter_name, :options, :filter_type

    def initialize(controller_class, filter_name, options, filter_type)
      @controller_class = controller_class
      @filter_name = filter_name
      @options = options
      @filter_type = filter_type
    end

    def actions_include?(action_name)
      action_methods.include?(action_name)
    end

    def populated_options_for(name)
      options.select {|opt_name,opt_value| opt_name == name && !opt_value.empty? }
    end

    private

    def action_methods
      controller_class.action_methods.map &:to_sym
    end

  end

  class Report

    attr_accessor :hits

    def self.instance
      @instance ||= Report.new
    end

    def initialize
     @hits = []
    end

    def add(hit)
      raise "Oops filter_decrufter can't handle this version of Rails" unless hit.controller_class.respond_to?(:action_methods)
      hits << hit
    end

    def find_problems
      hits.each do |hit|
        [:only, :except].each do |constraint_name|
          check_constraint(constraint_name, hit) if hit.populated_options_for(constraint_name)[constraint_name].present?
        end
      end
    end

    def check_constraint(name, hit)
      [hit.populated_options_for(name)[name]].flatten.each do |action_syms|
        [action_syms].flatten.each do |action_name|
          if !hit.actions_include?(action_name)
            puts "#{hit.controller_class} #{hit.filter_type} '#{hit.filter_name}' has an :#{name} constraint with a non-existent action name '#{action_name}'"
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
      filter_method_names.each {|s| patch_method(s) }
      load_all_controllers
      show_report
      nil
    end

    private

    def filter_method_names
      [:before, :around, :after].map {|s| ["#{s}_filter", "#{s}_action"]}.flatten.sort.map(&:to_sym)
    end

    def show_report
      Report.instance.find_problems
    end

    def patch_method(filter_sym)
      ActionController::Base.define_singleton_method(filter_sym) do |*args, &blk|
        filter_names = args.select {|a| a.kind_of?(Symbol) }
        filter_options = args.detect {|a| a.kind_of?(Hash) }
        if filter_options.present? && (filter_options[:only].present? || filter_options[:except].present?)
          filter_names.each do |name|
            Report.instance.add(FilterDecrufter::Hit.new(self, name, filter_options, filter_sym))
          end
        end
        super(*args, &blk)
      end
    end

    def load_all_controllers
      Rails.application.eager_load!
    end

  end
end
