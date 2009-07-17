module CommandParser
  def self.process(text)
    words = text.split

    verb = words.pop
    [verb, words]
  end
end
