require("gosu")

WIDTH = 800
HEIGHT = 600
TITLE = "Sounds and Music"

class Game < Gosu::Window
    def initialize
        super(WIDTH, HEIGHT)
        self.caption = TITLE

        @background = Gosu::Image.new("images/background.png")
        @bg_color = Gosu::Color.new(0, 0, 0)

        @text = Gosu::Image.from_text("Gosu", 80, font: "fonts/freesansbold.ttf")
        @text_x = 0
        @text_y = 0
        @text_w = @text.width
        @text_h = @text.height
        @text_vel = 3
        @text_xvel = @text_vel
        @text_yvel = @text_vel

        @sprite = Gosu::Image.new("images/ruby-logo.png")
        @sprite_x = 0
        @sprite_y = 0
        @sprite_vel = 5

        @ruby = Gosu::Sample.new("sounds/ruby.ogg")
        @gosu = Gosu::Sample.new("sounds/gosu.ogg")
        @music = Gosu::Song.new("music/freesoftwaresong-8bit.ogg")
        @music.play(looping=true)
    end

    def button_down(id)
        case id
        when Gosu::KB_ESCAPE
            close
        when Gosu::KB_M
            pause_music
        when Gosu::KB_SPACE
            rand_color
        end
    end

    def update
        update_text
        update_sprite
    end

    def draw
        Gosu.draw_rect(0, 0, self.width, self.height, @bg_color)
        @background.draw(0, 0)
        @text.draw(@text_x, @text_y)
        @sprite.draw(@sprite_x, @sprite_y)
    end

    def rand_color
        @bg_color.red = rand(256)
        @bg_color.green = rand(256)
        @bg_color.blue = rand(256)
        @ruby.play()
    end

    def update_text
        @text_x += @text_xvel
        @text_y += @text_yvel
        if @text_x < 0
            @text_xvel = @text_vel
            @gosu.play()
        elsif @text_x + @text_w > self.width
            @text_xvel = -@text_vel
            @gosu.play()
        end
        if @text_y < 0
            @text_yvel = @text_vel
            @gosu.play()
        elsif @text_y + @text_h > self.height
            @text_yvel = -@text_vel
            @gosu.play()
        end
    end

    def update_sprite
        if Gosu.button_down?(Gosu::KB_LEFT)
            @sprite_x -= @sprite_vel
        end
        if Gosu.button_down?(Gosu::KB_RIGHT)
            @sprite_x += @sprite_vel
        end
        if Gosu.button_down?(Gosu::KB_UP)
            @sprite_y -= @sprite_vel
        end
        if Gosu.button_down?(Gosu::KB_DOWN)
            @sprite_y += @sprite_vel
        end
    end

    def pause_music
        if @music.paused?
            @music.play(looping=true)
        else
            @music.pause
        end
    end

end

Game.new.show
