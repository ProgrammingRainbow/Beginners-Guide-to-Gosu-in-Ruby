require("gosu")

WIDTH = 800
HEIGHT = 600
TITLE = "Moving Text"

class Game < Gosu::Window
    def initialize
        super(WIDTH, HEIGHT)
        self.caption = TITLE

        @background = Gosu::Image.new("images/background.png")
        @bg_color = Gosu::Color.new(255, 0, 0, 0)

        @text = Gosu::Image.from_text("Gosu", 80, font: "fonts/freesansbold.ttf")
        @text_x = 0
        @text_y = 0
        @text_w = @text.width
        @text_h = @text.height
        @text_vel = 3
        @text_xvel = @text_vel
        @text_yvel = @text_vel
    end

    def button_down(id)
        case id
        when Gosu::KB_ESCAPE
            close
        when Gosu::KB_SPACE
            rand_color
        end
    end

    def update
        update_text
    end

    def draw
        Gosu.draw_rect(0, 0, self.width, self.height, @bg_color)
        @background.draw(0, 0)
        @text.draw(@text_x, @text_y)
    end

    def rand_color
        @bg_color.red = rand(256)
        @bg_color.green = rand(256)
        @bg_color.blue = rand(256)
    end

    def update_text
        @text_x += @text_xvel
        @text_y += @text_yvel
        if @text_x < 0
            @text_xvel = @text_vel
        elsif @text_x + @text_w > self.width
            @text_xvel = -@text_vel
        end
        if @text_y < 0
            @text_yvel = @text_vel
        elsif @text_y + @text_h > self.height
            @text_yvel = -@text_vel
        end
    end
end

Game.new.show
