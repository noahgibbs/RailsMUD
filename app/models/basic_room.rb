class BasicRoom < BasicObject
  # This has_many is used for exits
  has_many :basic_exits

  def exits_string
    es = (self.basic_exits.map { |e| e.name }).join(" ")
    es.empty? ? "(none)" : es
  end

  def show_to(player)
    self.name + "<br/>\n" +
    self.base_description + "<br/>\n" +
    "EXITS: " + exits_string
  end

end
