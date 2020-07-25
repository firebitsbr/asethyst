local dlg
local sprite

local config = {
    version = 'v0.1.0'
}

function export_as_grid()
    local data = {}

    table.insert(data, 'Grid((')
    table.insert(data, '\ttexture_width: ' .. sprite.width .. ',')
    table.insert(data, '\ttexture_height: ' .. sprite.height .. ',')
    table.insert(data, '\tcolumns: ' .. dlg.data.cols .. ',')
    table.insert(data, '\tsprite_count: ' .. #sprite.frames)
    table.insert(data, '))\n')

    return table.concat(data, '\n')
end

function export_as_list()
    local data = {}

    table.insert(data, 'List((')
    table.insert(data, '\ttexture_width: ' .. sprite.width .. ',')
    table.insert(data, '\ttexture_height: ' .. sprite.height .. ',')
    table.insert(data, '\tsprites: [')

    for i = 0, #sprite.frames do
        local x = i % dlg.data.cols
        local y = math.floor(i / dlg.data.cols)

        local s = '\t\t(\n'
            .. '\t\t\tx: ' .. x .. ',\n'
            .. '\t\t\ty: ' .. y .. ',\n'
            .. '\t\t\twidth: ' .. sprite.width .. ',\n'
            .. '\t\t\theight: ' .. sprite.height .. '\n'
            .. '\t\t),'
        
        table.insert(data, s)
    end

    table.insert(data, '\t],')
    table.insert(data, '))')

    return table.concat(data, '\n')
end

function build_dialog()
    local dlg = Dialog{
        title = 'Asethyst Exporter :) - ' .. config.version,
    }

    dlg:file{
        id = 'sheet_data',
        label = 'Spritesheet Data:',
        title = 'Save Spritesheet Data',
        save = true,
        filetypes = { 'ron' },
        entry = true
    }

    dlg:combobox{
        id = 'ron_type',
        label = 'Sprite Type:',
        option = 'Grid',
        options = { 'Grid', 'List' }
    }

    dlg:number{
        id = 'cols',
        label = 'Column Count',
        decimals = 0
    }

    dlg:separator()

    dlg:button{
        id = 'save',
        text = 'Save'
    }

    dlg:button{text = 'Cancel'}

    return dlg
end

function init()
    dlg = build_dialog()

    dlg:show()

    if dlg.data.save then
        sprite = app.activeSprite
        local filename = dlg.data.sheet_data

        local data = dlg.data.ron_type == 'Grid' 
            and export_as_grid() 
            or export_as_list()

        local file = io.open(filename, 'w')
        file:write(data)
    end
end

init()
