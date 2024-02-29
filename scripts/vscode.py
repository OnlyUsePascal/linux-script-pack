import subprocess
from unittest import registerResult
import sys

filePath = ''
if (len(sys.argv) > 1):
  filePath = sys.argv[1]

filePath = filePath.replace(' ', "\ ")
print(f'path = {filePath}')
# exit()

# Run the command
def exec(command : str) -> str: 
  result = subprocess.run(command, shell=True, check=True, stdout=subprocess.PIPE, text=True)
  return result.stdout

# get cur desk
cmd = "wmctrl -d"
curIdx = -1
for line in exec(cmd).split('\n'):
  if '*' in line:
    curIdx = line[0]
    break

print(f'Cur desktop = {curIdx}')

# get window
windowTitle = 'Visual Studio Code'
cmd = "wmctrl -l"
found = False
for line in exec(cmd).split('\n'): 
  if windowTitle in line:
    info = line.split(' ')
    idx = info[2]
    
    if (idx == curIdx and info[4] == 'Visual' ):
      found = True
      id = info[0]
      print('Merging window')
      exec(f'wmctrl -i -a {id}')
      exec(f'code --reuse-window {filePath}')
      break
  
if not found:
  cmd = f"code --new-window {filePath}"
  print('New window comin')
  exec(cmd)
  