class FileWriter
  attr_reader :file
  attr_accessor :content

  def initialize(file)
    @file = file
    @content = File.exist?(file) ? File.read(@file) : ""
  end

  def lines
    content.split("\n")
  end

  def replace(origin_content, now_content)
    @content = self.content.gsub(origin_content, now_content)
    self
  end

  def insert(new_content, line_num = -3)
    @content = lines.insert(line_num, new_content).join("\n") # unless @content =~ /#{new_content}/
    self
  end

  def search_method(n)
    lines.each_with_index do |line, i|
      return i if line =~ /def[\s\t]+#{n}/
    end
    lines.size 
  end

  def search_line_in_method(mn, line_content)
    method_line = search_method(mn)
    lines.each_with_index do |line, i|
      next if i <= method_line
      return i if line =~ /#{line_content}/
    end
    lines.size 
  end

  def save!
    File.open(@file, "wb"){|f| f.puts(@content) }
  end

  def save;save! end

  private
  def deal_data
  end
end
