function __init__()
    currentDir()
    readFile("/home/kali/Documents/logs/android logs/laravel-2024-04-20.log")
end


function currentDir() 
    println("Current Directory: ",pwd())
    return pwd()
end


function readFile(filePath)
    open(filePath) do f
        line = 0
        while ! eof(f)
            s = readline(f) 
            line += 1
            println("$line . $s")
        end
    close(filePath)
end

    
end



__init__()






