-- copy this block at the beginning of every lua file for ease of use AND load_file.lua in same directory
-------------------------------------------------------------------------
-------------------------------------------------------------------------
func, err = loadfile("./load_files.lua"); -- relative path can be used

if not func then
    print("\r\nError loading file:\r\n\r\n", err, "\r\n\r\n");
    os.exit(); -- end program and exit
else
    -- Execute the loaded func
    func();
end

-------------------------------------------------------------------------
-- load list of lua files and uses their functions (as if it was included like C programming language)
load_files({"./lib1.lua", "./lib2.lua"--[[does not exist but program continues]]});
-------------------------------------------------------------------------
-------------------------------------------------------------------------


-- external functions can now be used
-- example: 
print("------------------------------------------\r\n" ..
norm(3,4) ..    -- function from loaded lib
"\r\n" .. 
twice(2.5));    -- function from loaded lib
