

ERR_MESS_DIR_IS_EMPTY = "the directory is empty."
ERR_MESS_IS_NOT_DIR = "no such file or directory"

INFO_MESS_CREATE_FOLDER = "Result folder created successfully."

INPUT_MESS_DIRECTORY_PATH = "Enter directory path:"
INPUT_MESS_CHOOSE_READ_FILE = "Choose one of the following modes to read files: \n read all file in directory (0). \n read first file in directory (1). \n read last file in directory (2). \n Enter Number :"
INPUT_MESS_CHOOSE_SAVE_FILTER = "Choose one of the following modes to read files: \n save (0). \n does not save (1).  \n Enter Number :"

result_dir_name = "result"
result_file_name = "result.log"

save_file_state = "-1"
read_file_state = "-1"

function main()
    __init__()
end


function __init__()
    println(INPUT_MESS_DIRECTORY_PATH)
    dir_path = readInput()

    println(INPUT_MESS_CHOOSE_READ_FILE)
    global read_file_state = readInput()


    println(INPUT_MESS_CHOOSE_SAVE_FILTER)
    global save_file_state = readInput()

  
   
 
    if save_file_state == "0"
        println("/home/kali/Documents/logs/all logs")
        createFolder(dir_path)
        createLogFile(dir_path)
    end 


    if read_file_state == "0"
        readAllFile(dir_path)
    elseif read_file_state == "1"
        readFirstFile(dir_path)
    elseif read_file_state == "2"
        readLastFile(dir_path)
    end

end


function currentDir() 
    println("Current Directory: ",pwd())
    return pwd()
end


function readFile(filePath,pathDir)
    println("file path : $filePath")
    file_path_result_log = pathDir * "/" *result_dir_name * "/" * result_file_name
    open(filePath,"r") do f
        line = 0
        while ! eof(f)
            s = readline(f) 
            line += 1

            println(save_file_state)
            if save_file_state == "0"
                insertToResultFileLog(file_path_result_log,s)
            end
        
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
        readFile(file_path,dir)
       # dump(stat(f)) # you can customize what you want to print
    end
end

function readFirstFile(dir)
    file_name = first(readdir(dir))
    file_path = dir * "/" * file_name
    readFile(file_path,dir)
end


function readLastFile(dir)
    file_name = last(readdir(dir))
    file_path = dir * "/" * file_name
    readFile(file_path,dir)
   
end

function isDirFile(dir)
    count_of_file = length(readdir(dir))
    if count_of_file > 0
        return true
    else
        println("Error: $ERR_MESS_DIR_IS_EMPTY")
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

function checkExistDir(dir)
    try
        readdir(dir)
        return true
    catch
        return false

    end
end


function createFolder(dir)
    path = dir * "/$result_dir_name" 
    if  isExistsDir(dir)
        if ! checkExistDir(path)
        mkdir(path) 
        println("Info: $INFO_MESS_CREATE_FOLDER")
        end
    end
end


function createLogFile(dir)
    file =  dir * "/" *result_dir_name * "/" * result_file_name
    touch(file)
end

function readInput()
    return readline()
end

function insertToResultFileLog(filePath,text)
    println("s s: $filePath")
    file = open(filePath,"a")
    write(file,text)
  
end


main()








