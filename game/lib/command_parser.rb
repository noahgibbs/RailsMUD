module CommandParser
  def self.process(text)
    words = text.split

    verb = words.shift
    [verb, words]
  end
end
