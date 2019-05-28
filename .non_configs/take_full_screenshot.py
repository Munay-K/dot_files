import os
import pyscreenshot as ImageGrab
import time

if __name__ == "__main__":
    img = ImageGrab.grab()
    os.chdir(os.environ['HOME'] + '/Pictures/')
    img.save('full_snap__' + str(int(time.time())) + '.png', 'PNG')
