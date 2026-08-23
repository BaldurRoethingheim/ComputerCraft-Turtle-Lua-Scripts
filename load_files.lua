function load_files(file_list)
    for _, file in ipairs(file_list) do
        local f, err = loadfile(file)
        if f then
            local ok, res = pcall(f)
            if not ok then
                print("Execution error in " .. file .. ": " .. res)
            end
        else
            print("Load error in " .. file .. ": " .. err)
        end
    end
end
