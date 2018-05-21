class BitmapEditor

  attr_reader :generate_image, :clear_image, :colour_pixel, 
              :colour_vertical, :colour_horizontal, :show

  def generate_image(m, n, default_colour="O")
    @m = m
    @n = n
    @default_colour = default_colour
    @image = Array.new(m){ Array.new(n){default_colour} }
  end

  def clear_image()
    generate_image(@m, @n, @default_colour)
  end

  def colour_pixel(pixel_x, pixel_y, colour)
    begin
      @image[pixel_y - 1][pixel_x - 1] = colour
    rescue IndexError
      print_and_exit
    end
  end

  def colour_vertical(pixel_x, pixel_y_start, pixel_y_end, colour)
    while pixel_y_start - 1 < pixel_y_end do
      begin
        @image[pixel_y_start - 1][pixel_x - 1] = colour
      rescue IndexError
        print_and_exit
      end
      pixel_y_start += 1
    end
  end

  def colour_horizontal(pixel_x_start, pixel_x_end, pixel_y, colour)
    while pixel_x_start - 1 < pixel_x_end do
      begin
        @image[pixel_y - 1][pixel_x_start - 1] = colour
      rescue IndexError
        print_and_exit
      end
      pixel_x_start += 1
    end
  end

  def show
    @image.each do |row|
      puts "#{row.join()}\n" 
    end
  end

  def validate_input(expected_length, input)
    given_length = input.length
    if expected_length != given_length
      print_and_exit("Command not valid")
    end
  end

  def print_and_exit(msg="X or Y outside canvas.")
    puts msg
    exit(1)
  end

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      line = line.chomp
      line_split = line.split(' ')
      case line_split[0]
      when 'I'
        validate_input(3, line_split)
        x, y = line_split[1].to_i, line_split[2].to_i
        generate_image y, x
      when 'L'
        validate_input(4, line_split)
        x, y, colour = line_split[1].to_i, line_split[2].to_i, line_split[3]
        colour_pixel x, y, colour
      when 'V'
        validate_input(5, line_split)
        x, y1, y2, colour = line_split[1].to_i, line_split[2].to_i, line_split[3].to_i, line_split[4]
        colour_vertical x, y1, y2, colour
      when 'H'
        validate_input(5, line_split)
        x1, x2, y, colour = line_split[1].to_i, line_split[2].to_i, line_split[3].to_i, line_split[4]
        colour_horizontal x1, x2, y, colour
      when 'S'
        show  
      else
        puts 'unrecognised command :('
      end
    end
  end
end
