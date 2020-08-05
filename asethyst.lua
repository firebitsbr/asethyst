local dlg
local sprite

local config = {
   version = "v0.2.0",
   api_version = 11,
}

function export_as_grid()
   local data = {}

   local x_count = dlg.data.cols
   local y_count = math.ceil(#sprite.frames / dlg.data.cols)

   table.insert(data, "Grid((")
   table.insert(data, "\ttexture_width: " .. sprite.width * x_count .. ",")
   table.insert(data, "\ttexture_height: " .. sprite.height * y_count .. ",")
   table.insert(data, "\tcolumns: " .. dlg.data.cols .. ",")
   table.insert(data, "\tsprite_count: " .. #sprite.frames)
   table.insert(data, "))\n")

   return table.concat(data, "\n")
end

function export_as_list()
   local data = {}

   local x_count = dlg.data.cols
   local y_count = math.ceil(#sprite.frames / dlg.data.cols)

   table.insert(data, "List((")
   table.insert(data, "\ttexture_width: " .. sprite.width * x_count .. ",")
   table.insert(data, "\ttexture_height: " .. sprite.height * y_count .. ",")
   table.insert(data, "\tsprites: [")

   for i = 0, #sprite.frames - 1 do
      local x = i % dlg.data.cols
      local y = math.floor(i / dlg.data.cols)

      local s = "\t\t(\n"
         .. "\t\t\tx: " .. x * sprite.width .. ",\n"
         .. "\t\t\ty: " .. y * sprite.height .. ",\n"
         .. "\t\t\twidth: " .. sprite.width .. ",\n"
         .. "\t\t\theight: " .. sprite.height .. "\n"
         .. "\t\t),"
      
      table.insert(data, s)
   end

   table.insert(data, "\t],")
   table.insert(data, "))")

   return table.concat(data, "\n")
end

function build_dialog()
   local dlg = Dialog{
      title = "Asethyst Exporter :) - " .. config.version,
   }

   dlg:file{
      id = "sheet_data",
      label = "Spritesheet Data:",
      title = "Save Spritesheet Data",
      save = true,
      filetypes = { "ron" },
      entry = true
   }

   dlg:combobox{
      id = "ron_type",
      label = "Sprite Type:",
      option = "List",
      options = { "Grid", "List" }
   }

   dlg:number{
      id = "cols",
      label = "Column Count",
      decimals = 0
   }

   dlg:separator()

   dlg:button{
      id = "save",
      text = "Save"
   }

   dlg:button{text = "Cancel"}

   return dlg
end

function build_error_dialog(msg, expected_value, found_value)
   local dlg = Dialog{
      title = "Asethyst Exporter :( - " .. config.version,
   }

   dlg:separator{
      text = "ERROR"
   }

   dlg:label{
      label = "Message:",
      text = msg
   }

   dlg:label{
      label = "Expected Value:",
      text = expected_value
   }

   dlg:label{
      label = "Found Value:",
      text = found_value
   }

   return dlg
end

function init()
   if app.apiVersion < config.api_version then
      local dlg = build_error_dialog(
         "Your Aseprite API version is out of date!",
         config.api_version,
         app.apiVersion
      )

      dlg:show{
         bounds = Rectangle(300, 300, 650, 300)
      }

      return
   end

   dlg = build_dialog()

   dlg:show()

   if dlg.data.save then
      sprite = app.activeSprite
      local filename = dlg.data.sheet_data

      local data = dlg.data.ron_type == "Grid" 
         and export_as_grid() 
         or export_as_list()

      local file = io.open(filename, "w")
      file:write(data)
   end
end

init()
