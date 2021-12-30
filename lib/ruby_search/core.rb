require 'forwardable'

module RubySearch
  class Core
    extend Forwardable
    def_delegators :@loader, :stores, :names, :classes

    def initialize(names)
      @loader = Loader.setup(names)
    end
  end
end
