RSpec.describe "matching error message with string" do
  
  it "matches the wrong_color_format error message" do
    expect { raise ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format }.
      to raise_error('Wrong color format')
  end  

  it "matches the missing_color_code error message" do
    expect { raise ExceptionHandler::ColorCodeError, ErrorMessage.missing_color_code }.
      to raise_error('Color code is missing')
  end

  it "matches the wrong_color_code error message" do
    expect { raise ExceptionHandler::ColorCodeError, ErrorMessage.wrong_color_code }.
      to raise_error('Wrong color code')
  end
end