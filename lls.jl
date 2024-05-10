

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
 #@sync test()
end


function test()
    n = 10
a = zeros(n)
Threads.@threads for i = 1:n
    a[i] = Threads.threadid()
end
println(a)
end

function __init__()
    println(INPUT_MESS_DIRECTORY_PATH)
    dir_path = readInput()

    println(INPUT_MESS_CHOOSE_READ_FILE)
    global read_file_state = readInput()


    println(INPUT_MESS_CHOOSE_SAVE_FILTER)
    global save_file_state = readInput()

  
   
 
    if save_file_state == "0"
        createFolder(dir_path)
        createLogFile(dir_path)
    end 

    showFieldsState()

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


function readFileWithSave(filePath,result_file_path)
    println("file path : $filePath")

    open(filePath,"r") do f
        line = 0
        while ! eof(f)
            s = readline(f) 
            line += 1
            
                insertToResultFileLog(result_file_path,s)
        
        end
   
    end
end


function readFileWithoutSave(filePath)
    println("file path : $filePath")

    open(filePath,"r") do f
        line = 0
        while ! eof(f)
            s = readline(f) 
            line += 1
        
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


    if save_file_state == "0"
        op_result_log_file = openFile(dir)
   end

    foreach(readdir(dir)) do f
        file_path = dir * "/" * f

        if save_file_state == "0"
            readFileWithSave(file_path,op_result_log_file)
        else
            readFileWithoutSave(file_path)
       end
       
       # dump(stat(f)) # you can customize what you want to print
    end
end

function readFirstFile(dir)
    file_name = first(readdir(dir))
    file_path = dir * "/" * file_name

    if save_file_state == "0"
        op_result_log_file = openFile(dir)
   end

    if save_file_state == "0"
        readFileWithSave(file_path,op_result_log_file)
    else
        readFileWithoutSave(file_path)
   end

 
end


function readLastFile(dir)
    file_name = last(readdir(dir))
    file_path = dir * "/" * file_name
   
    if save_file_state == "0"
        op_result_log_file = openFile(dir)
   end

    if save_file_state == "0"
        readFileWithSave(file_path,op_result_log_file)
    else
        readFileWithoutSave(file_path)
   end
   
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

function openFile(dir)
    file_path_result_log = dir * "/" *result_dir_name * "/" * result_file_name
    return open(file_path_result_log,"a")
end

function insertToResultFileLog(file,text)
    write(file,text)
end

function showFieldsState()
    message = "\n\n Configs: \n - state read file: $read_file_state \n - state save file: $save_file_state \n\n Start App -> \n\n"
    println(message)
end


main()








