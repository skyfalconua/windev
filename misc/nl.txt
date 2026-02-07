import pyautogui
import time

pyautogui.FAILSAFE = False

def main():
  try:
    print('Prevent Windows screenlock')
    print('Press CTRL+C to stop.')

    while True:
      pyautogui.keyDown('shift')
      pyautogui.keyUp('shift')
      time.sleep(60)

  except KeyboardInterrupt:
    print('Stopped')

  except Exception as ex:
    print('Error: ', ex)

if __name__ == "__main__":
  main()
