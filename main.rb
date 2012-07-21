class Number_conversion

  def initialize
    @result = ''
    insert_number
  end

  def insert_number
    puts 'Enter any number between 1 to 1000'
    @num_to_convert = gets.chomp.to_i
    check_number? ? convert_to_roman(@num_to_convert) : warning
  end

  def check_number?
    @num_to_convert >=1 && @num_to_convert <= 1000 ? true : false
  end

  def convert_to_roman(partial_number)
    if(partial_number > 0)
      range_for_number(partial_number)
      if(@small_element == '')
        @result = @result.to_s + @arr_roman_format[@large_element][1].to_s
      else
        if( partial_number > 10  && @arr_roman_format[@large_element][0] - partial_number > 10  )
          @result = @result.to_s  + @arr_roman_format[@small_element][1].to_s
          convert_to_roman(partial_number - @arr_roman_format[@small_element][0])
        else if ( partial_number > 10  && @arr_roman_format[@large_element][0] - partial_number <= 10  )
            @result = 'X' + @arr_roman_format[@large_element][1].to_s + @result.to_s
            convert_to_roman(10 - (@arr_roman_format[@large_element][0] - partial_number))
          else if ( partial_number < 10  && @arr_roman_format[@large_element][0] - partial_number <= 1  )
              @result = @result.to_s + 'I' + @arr_roman_format[@large_element][1]
            else if ( partial_number < 10  && @arr_roman_format[@large_element][0] - partial_number > 1  )
                @result = @result.to_s  + @arr_roman_format[@small_element][1].to_s
                convert_to_roman(partial_number - @arr_roman_format[@small_element][0])
              end
            end
          end
        end
      end
    end
  end

  def range_for_number(partial_number)
    @arr_roman_format = [[1,'I'],[5,'V'],[10,'X'],[50,'L'],[100,'C'],[500,'D'],[1000,'M']]
    for i in (0..5)
      if( partial_number > @arr_roman_format[i][0] && partial_number < @arr_roman_format[i + 1][0]  || partial_number == 1 )
        @small_element = i
        @large_element = i+1
        break
      else if (partial_number == @arr_roman_format[i + 1][0] )
          @small_element = ''
          @large_element = i+1
        end
      end
    end
  end

  def warning
    puts 'Number must be between 1 to 1000'
    insert_number
  end

  def show_result
    puts @result
  end

end

conversion = Number_conversion.new
conversion.show_result
