class FileWriter
  attr_reader :file
  attr_accessor :content

  def initialize(file)
    @file = file
    @content = File.read(@file)
  end

  def lines
    content.split("\n")
  end

  def replace(origin_content, now_content)
    @content = self.content.gsub(origin_content, now_content)
    self
  end

  def insert(content, line_num = -3)
    @content = lines.insert(line_num, content).join("\n")
    self
  end

  def save!
    File.open(@file, "wb"){|f| f.puts(@content) }
  end

  private
  def deal_data
  end
end
