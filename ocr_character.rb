class OCRCharacter

OCR_CHARACTERS = {
                  " _ "+
                  "| |"+
                  "|_|" => "0",

                  "   "+
                  "  |"+
                  "  |" => "1",

                  " _ "+
                  " _|"+
                  "|_ " => "2",

                  " _ "+
                  " _|"+
                  " _|" => "3",

                  "   "+
                  "|_|"+
                  "  |" => "4",

                  " _ "+
                  "|_ "+
                  " _|" => "5",

                  " _ "+
                  "|_ "+
                  "|_|" => "6",

                  " _ "+
                  "  |"+
                  "  |" => "7",

                  " _ "+
                  "|_|"+
                  "|_|" => "8",

                  " _ "+
                  "|_|"+
                  " _|" => "9"
                  }

  def initialize
    build_mapping_without_spaces 
  end

  def build_mapping_without_spaces
    @character_map = { }
    OCR_CHARACTERS.each { | ocr_char, char | @character_map[ocr_char.strip] = char }
  end

  def convert_to_char(candidate_ocr_char)
    @character_map[candidate_ocr_char.strip] || "?"
  end

end