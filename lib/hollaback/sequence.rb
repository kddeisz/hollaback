module Hollaback
  class Sequence
    attr_reader :befores, :afters, :main

    def initialize(args = {}, &main)
      @main    = main
      @befores = args.fetch(:befores, [])
      @afters  = args.fetch(:afters, [])
    end

    def +(other)
      raise ArgumentError, 'Can only add to another sequence' unless other.is_a?(Sequence)
      Sequence.new(befores: befores + other.befores, afters: afters + other.afters, &other.main)
    end

    def before(&before)
      befores << before
      self
    end

    def after(&after)
      afters << after
      self
    end

    # rubocop:disable Performance/RedundantBlockCall
    def around(&around)
      Sequence.new do |target|
        around.call(target) { call(target) }
      end
    end

    def call(target)
      befores.each { |before| before.call(target) }
      value = main.call(target)
      afters.each { |after| after.call(target) }
      value
    end
  end
end
