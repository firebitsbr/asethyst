# Asethyst

Amethyst is a data-driven game-engine written in Rust (<https://amethyst.rs>).

Amethyst uses a custom, RON (*Rusty Object Notation*) based config format to
describe spritesheets for import and usage.

The goal of *Asethyst* is to provide a simple and easy to use export variant for
spritesheets created in Aseprite to directly store the information in the
correct format instead of writing it by hand or converting a JSON file into a
RON file!

## Installation

In order to 'install' Asethyst, download the `asethyst.lua` file of the current
release (or any other version you would like!) and save it in Aseprite's script
folder!

If this is your first Aseprite script you want to install, you can find your
script folder by clicking `File > Scripts > Open Scripts Folder` in Aseprite.

## How to use Asethyst

1. Open the Aseprite file of the sprite you wish to export
1. Start the script by clicking `File > Scripts > asethyst`
1. You will be prompted with a new dialogue window
    * Choose a target file/location for the exported spritesheet data file
    * You can choose between `List` and `Grid` as the spritesheet type (`List`
    by default)
    * Set the number of columns in your spritesheet (e.g. if you have exported
    your sprite as a 4x4 spritesheet, set this value to 4)
1. Click `Save` and try it out in Amethyst! :)
