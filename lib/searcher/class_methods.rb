require 'searcher/config'
require 'shellwords'

module Searcher
  module ClassMethods
    def searcher(&block)
      Searcher.classes << self unless Searcher.classes.include?(self)
      @config = Searcher::Config.new.instance_exec(&block)
      @config[:labels].each do |name, config|
        association = reflect_on_association(config[:from])
        association_table = association.klass.arel_table

        next unless %i[has_and_belongs_to_many belongs_to].include?(association.macro)

        scope = lambda do |q, field|
          joins(config[:from])
            .where(association_table[field].eq(q))
        end
        self.scope "by_#{name}", scope
      end
    end

    def search(query)
      klass = self

      result = Shellwords.split(query).inject(klass) do |kls, piece|
        next kls unless piece.include?(':')

        name, q = piece.split(':')
        label = @config[:labels][name.to_sym]

        next kls unless label

        kls.send("by_#{name}", q, label[:field])
      end

      result.all
    end
  end
end
