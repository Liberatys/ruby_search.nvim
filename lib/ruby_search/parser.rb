module RubySearch
  class Parser
    class << self
      def parse_class_call(query)
        parts = query.replace('.new', '').split(':')
      end
    end
  end
end
