require_relative 'ocr_char_converter'

class OCRLineConverter

  def initialize(char_converter, num_chars_in_line)
    @converter = char_converter
    @line_size = num_chars_in_line
  end

  def convert_line(ocr_line)
    ocr_chars = split_ocrline_into_ocrchars(ocr_line)
    ocr_chars.reduce("") { |a, e| a + @converter.ocrchar_to_char(e) }
  end

  def split_ocrline_into_ocrchars(ocr_line)
    lines_from_ocrline = ocr_line.split("\n")

    #TODO: No doubt there's a more ruby-esque way to do this - looking to learn!
    ocr_chars = Array.new
    (0..index_of_last_ocrchar).step(size_of_ocr_char) do |index|
      ocr_chars.push ( get_ocrchar_at_index(lines_from_ocrline, index) )
    end
    ocr_chars
  end

  def get_ocrchar_at_index(sub_lines, index)
    sub_lines[0].slice(index..index+size_of_ocr_char-1) +
    sub_lines[1].slice(index..index+size_of_ocr_char-1) +
    sub_lines[2].slice(index..index+size_of_ocr_char-1) 
  end

  def index_of_last_ocrchar
     @line_size*size_of_ocr_char-size_of_ocr_char
  end

  def size_of_ocr_char
    3
  end
    
end