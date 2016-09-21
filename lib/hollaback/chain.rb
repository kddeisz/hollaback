module Hollaback
  class Chain
    attr_reader :callbacks

    def initialize
      @callbacks = []
    end

    def before(execute = nil, &block)
      build(:before, execute, &block)
    end

    def after(execute = nil, &block)
      build(:after, execute, &block)
    end

    def around(execute = nil, &block)
      build(:around, execute, &block)
    end

    def compile(&block)
      if callbacks.any?
        callbacks.inject(Sequence.new(&block)) do |sequence, callback|
          sequence.send(callback.type, &callback.build)
        end
      else
        block
      end
    end

    private

    def build(type, execute, &block)
      callbacks << Callback.new(type, execute, &block)
    end
  end
end
