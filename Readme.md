# QLTool

A tool for generating QuickLook preview panels and preview image data.
The built product is an application package but the functionality is controlled through command line parameters.
This tool is not user friendly and is meant for use by scripts.

## Usage

All commands are run through calling the executable inside the app package.
The first argument is a command, the second is a file path and the subsequent arguments are additional info.

```bash
# This prints the base64 png image preview data of somefile.png at size 100x100
./QLTool.app/Contents/MacOS/QLTool dp somefile.png 100 100
```

### Opening Preview Panels

The `p` command opens a preview panel for the file and focuses it, it can be closed with any key.
The path can be either absolute or relative but the app will hang if it is invalid, crashing is a TODO.

```bash
# Example: This opens a preview panel for iPhoto
./QLTool.app/Contents/MacOS/QLTool p "/Applications/iPhoto.app"
```

### Printing Preview Image Data

The `d` command generates quicklook preview images of any file and output the base64 encoded png data.
It has two modes `di` generates an icon preview like Finder's icon mode, the `dp` mode generates a preview
like those in quicklook panels. After the path (which can be relative) you must pass the desired dimensions of the preview image.

```bash
# Example: This prints the base64 png image preview data of somefile.png at size 100x100
./QLTool.app/Contents/MacOS/QLTool dp somefile.png 100 100
# Example: This prints the base64 png icon preview data of somefile.png at size 100x120
./QLTool.app/Contents/MacOS/QLTool di mydocument.txt 100 120
```

## iTerm2 Inline images

The iTerm2 terminal emulator has special escape codes that print images inline.
QLTool can generate these escape codes to print previews directly to the terminal.
The syntax is the same as the `d` command except using `t`.

```bash
# Example: This displays the image preview data of somefile.png at size 100x100
./QLTool.app/Contents/MacOS/QLTool tp somefile.png 100 100
# Example: This displays the icon preview data of somefile.png at size 100x120
./QLTool.app/Contents/MacOS/QLTool ti mydocument.txt 100 120
```
