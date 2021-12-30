require 'rdoc/ri/paths'

module RubySearch
  class Loader
    attr_reader :stores, :names, :classes

    def initialize(names)
      @names = names
      @classes = {}
      @stores = []
      @rdoc_dirs = []
    end

    class << self
      def setup(names)
        instance = new(names)
        %(stores classes).each do |method|
          instance.send(:"load_#{method}")
        end
        instance
      end
    end

    private

    def load_stores
      RDoc::RI::Paths.each(
        %i[use_system use_site use_home use_gems extra_doc_dirs].map { |option| options[option] }
      ).each do |path, type|
        next unless File.exist?(path)

        @rdoc_dirs << path
        store = RDoc::RI::Store.new(path, type)
        store.load_cache
        @stores << store
      end
    end

    def load_classes
      @classes = {}

      @stores.each do |store|
        store.cache[:modules].each do |store_module|
          @classes[store_module] ||= []
          @classes[store_module] << store
        end
      end
    end

    def options
      @options ||= {
        width: 72,
        use_cache: true,
        profile: false,
        use_system: true,
        use_site: true,
        use_home: true,
        use_gems: true,
        extra_doc_dirs: []
      }
    end
  end
end
