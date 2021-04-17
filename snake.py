import pygame
import random

def tile_to_pixel(coord):
    return coord[0] * 10, coord[1] * 10

pygame.init()

screen_size = 640, 480
snake_size = (10,10)
hole_rect = pygame.Rect(tile_to_pixel((random.randint(0,63), random.randint(0,47))), snake_size)

snake_length = random.randint(6,10)

# takes a tile coordinate and a direction
# returns a new tile coordinate
def move(tile, direction):
    x, y = tile
    if direction == "up":
        y -= 1
    elif direction == "down":
        y += 1
    elif direction == "left":
        x -= 1
    else:
        x += 1
    return x,y

def random_direction():
    directions = ["up","down","left","right"]
    return(directions[random.randint(0,3)])

def valid_tile(tile):
    x,y = tile
    rect = pygame.Rect(tile, (10,10))
    # reach window bounds
    if (x < 0) or (y < 0) or (x > 63) or (y > 47):
        return(False)
    else:
        return(True)

class Snake:
    
    def __init__(self):
        slength = random.randint(6,10)
        self.found_hole = False
        self.head_tile = random.randint(9,54), random.randint(9,38)
        self.body = []
        self.direction = random_direction()
        tile = self.head_tile
        for i in range(0,slength):
            rect = pygame.Rect(tile_to_pixel(tile), snake_size)
            self.body.append(rect)
            tile = move(tile, self.direction)

    def contains_tile(self,tile):
        rect = pygame.Rect(tile_to_pixel(tile),(10,10))
        return(rect.collidelist(self.body)>-1)

    def update(self):
        #rect = self.body[0]
        new_tile = (-1,-1)
        while not valid_tile(new_tile) or self.contains_tile(new_tile):
            if random.randint(0,3) == 1:
                self.direction = random_direction()
            new_tile = move(self.head_tile, self.direction)
        self.head_tile = new_tile
        rect= pygame.Rect(tile_to_pixel(new_tile), snake_size)
        self.body = self.body[:-1]
        self.body.insert(0, rect)

    def render(self, surface):
        pygame.draw.rect(surface, (255, 0, 0), self.body[0])
        for segment in self.body[1:]:
            pygame.draw.rect(surface, (0, 255, 0), segment)


display = pygame.display.set_mode(screen_size, pygame.HWSURFACE | pygame.DOUBLEBUF)
display.fill([255,255,255])

running = True
snake = Snake()
snake.render(display)

while running:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    display.fill([255,255,255])
    pygame.draw.rect(display, (0,0,0), hole_rect)
    snake.update()
    snake.render(display)
    pygame.display.flip()
    pygame.time.delay(50)

pygame.quit()
