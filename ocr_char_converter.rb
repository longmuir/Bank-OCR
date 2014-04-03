class OCRCharConverter

OCR_CHARACTERS = {
                  " _ "+
                  "| |"+
                  "|_|" => 0,

                  "   "+
                  "  |"+
                  "  |" => 1,

                  " _ "+
                  " _|"+
                  "|_ " => 2,

                  " _ "+
                  " _|"+
                  " _|" => 3,

                  "   "+
                  "|_|"+
                  "  |" => 4,

                  " _ "+
                  "|_ "+
                  " _|" => 5,

                  " _ "+
                  "|_ "+
                  "|_|" => 6,

                  " _ "+
                  "  |"+
                  "  |" => 7,

                  " _ "+
                  "|_|"+
                  "|_|" => 8,

                  " _ "+
                  "|_|"+
                  " _|" => 9
                  }

  def ocrchar_to_char(ocr_character)
    OCR_CHARACTERS[ocr_character].to_s
  end

end