import os
import strutils
import algorithm
import terminal
import tables
import sequtils

var colourMap = {"ignore": fgGreen, "exists": fgRed, "create": fgBlue}.toTable

proc echoWithColour(colour: ForegroundColor, text: string) =
  setForegroundColor(colour, true)
  echo text
  resetAttributes()

proc contractTilde(path: string): string =
  var home = expandTilde("~/")
  if path.startsWith(home):
    return "~" / path[home.len .. ^1]
  return path

proc makePathRelative(path: string): string =
  if path.startsWith(getCurrentDir()):
    return path[getCurrentDir().len + 1 .. ^1]
  return path

proc files(dir: string): seq[string] =
  var paths = newSeq[string]()
  for child in walkDir(dir):
    paths.add(child.path)
    paths.add(files(child.path))
  sort(paths, system.cmp)
  return paths

var really = commandLineParams().contains("--really")
if not really:
  echoWithColour(fgBlue, "You didn't specify --really so this is a dry run. Symlinks will not be created.")
  echo ""

type
  Action = object
    title: string
    link: string
    target: string

var actions = newSeq[Action]()

for path in files(getCurrentDir()):
  var isSymlinkable = path.endsWith(".symlink")
  if isSymlinkable:
    var target = path

    var link = path[getCurrentDir().len + 1 .. ^1]
    link = link[link.find("/") + 1 .. ^1]
    link = expandTilde("~" / link)
    link.removeSuffix(".symlink")

    var title: string
    if symlinkExists(link) and expandSymlink(link) == target:
      title = "ignore"
    elif fileExists(link) or symlinkExists(link):
      title = "exists"
    else:
      title = "create"

    actions.add(Action(title: title, link: link, target: target))

echoWithColour(colourMap["ignore"], "[ignore] = These symlinks will be ignored, because they already exist.")
echoWithColour(colourMap["exists"], "[exists] = These symlinks could not be created because something exists in their place (you need to take care of these).")
echoWithColour(colourMap["create"], "[create] = These symlinks don't exist, so they will be created.")
echo ""

if actions.len > 0:
  var maxPathWidth = map(actions, proc(action: Action): int = action.link.len).max()
  for action in actions:
    var colour = colourMap[action.title]
    var alignedLink = contractTilde(action.link)
    if alignedLink.len < maxPathWidth:
      alignedLink = alignedLink & ' '.repeat(maxPathWidth - alignedLink.len)
    echoWithColour colour, "[" & action.title & "] " & alignedLink & " => " & makePathRelative(action.target)
    if action.title == "create" and really:
      createSymlink(action.target, action.link)
