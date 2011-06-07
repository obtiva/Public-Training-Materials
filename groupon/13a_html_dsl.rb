class Markup
  attr_reader :name, :children

  def self.document(&block)
    doc = new("", &block)
    doc
  end

  def initialize(name, &block_body)
    @children = []
    @name = name

    if block_given?
      @text = instance_eval(&block_body)
    end
  end

  def tag(body)
    return body if [nil, ""].include? name
    "<#{name}>#{body}</#{name}>"
  end

  def to_s
    tag(@text || children.join)
  end

  def method_missing(name, &body)
    @children << Markup.new(name, &body)
    nil
  end
end

doc = Markup.document do
  html do 
    title { "Foo" }
    body do 
      "Hello fantastic!"
    end
  end
end
puts doc

