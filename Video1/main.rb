require("gosu")

WIDTH = 800
HEIGHT = 600
TITLE = "Open and Close"

class Game < Gosu::Window
    def initialize
        super(WIDTH, HEIGHT)
        self.caption = TITLE
    end

    def button_down(id)
        case id
        when Gosu::KB_ESCAPE
            close
        end
    end

    def update
    end
  
    def draw
    end
end

Game.new.show
