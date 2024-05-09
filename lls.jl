ERR_MESS_DIR_IS_EMPTY = "the directory is empty."
ERR_MESS_IS_NOT_DIR = "no such file or directory"

function __init__()
    currentDir()
    #readFile("/home/kali/Documents/logs/android logs/laravel-2024-04-20.log")
    #listOfFilesInDir("/home/kali/Documents/logs/android logs/")
    #readLastFile("/home/kali/Documents/logs/android logs/test/")
    isExistsDir("/home/kali/Documents/logs/all logs/test12")
end


function currentDir() 
    println("Current Directory: ",pwd())
    return pwd()
end


function readFile(filePath)
    println("file path : $filePath")
    open(filePath,"r") do f
        line = 0
        while ! eof(f)
            s = readline(f) 
            line += 1
            println("$line . $s")
        end
   
    end
end


function listOfFilesInDir(dir)
    foreach(readdir(dir)) do f
        println("File name: ",f)
       # dump(stat(f)) # you can customize what you want to print
    end
end


function readAllFile(dir)
    file_path = ""
    foreach(readdir(dir)) do f
        file_path = dir * "/" * f
        readFile(file_path)
       # dump(stat(f)) # you can customize what you want to print
    end
end

function readFirstFile(dir)
    file_name = first(readdir(dir))
    file_path = dir * "/" * file_name
    readFile(file_path)
end


function readLastFile(dir)
    file_name = last(readdir(dir))
    file_path = dir * "/" * file_name
    readFile(file_path)
   
end

function isDirFile(dir)
    count_of_file = length(readdir(dir))
    if count_of_file > 0
        return true
    else
        println(ERR_MESS_DIR_IS_EMPTY)
        return false
    end
end

function isExistsDir(dir)
    try
        readdir(dir)
        return true
    catch
        println("Error: $ERR_MESS_IS_NOT_DIR")
        return false

    end
end

__init__()






