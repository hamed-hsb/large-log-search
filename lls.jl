

ERR_MESS_DIR_IS_EMPTY = "the directory is empty."
ERR_MESS_IS_NOT_DIR = "no such file or directory"

INFO_MESS_CREATE_FOLDER = "Result folder created successfully."

INPUT_MESS_DIRECTORY_PATH = "Enter directory path:"
INPUT_MESS_CHOOSE_READ_FILE = "Choose one of the following modes to read files: \n read all file in directory (0). \n read first file in directory (1). \n read last file in directory (2). \n Enter Number :"
INPUT_MESS_CHOOSE_SAVE_FILTER = "Choose one of the following modes to read files: \n save (0). \n does not save (1).  \n Enter Number :"
INPUT_MESS_PHRASE_TO_SEARCH = "Enter a phrase to search in the files:\n"


result_dir_name = "result"
result_file_name = "result.log"

save_file_state = "-1"
read_file_state = "-1"
phrase_filter = " "

function main()
   #y = ["hamed safarzad","vahid","farzad","farshad"]
   __init__()
   #println(contains("{gps_adid_attempt country IR api level 33 event_buffering_enabled 1 hardware_name TKQ1.221114.001 test-keys subsession_count 4 mnc 11 os_version 13 android_uuid 2326d605-a3e5-4ae0-932d-8e14764e161e","gps"))
 
end


function list_files_in_path(path::String)
    # Get a list of all items (files and directories) in the path
    all_items = readdir(path)
    
    # Filter out directories to get only files
    files = filter(item -> isfile(joinpath(path, item)), all_items)
    
    return files
end

function __init__()
    println(INPUT_MESS_DIRECTORY_PATH)
    dir_path = readInput()

    println(INPUT_MESS_CHOOSE_READ_FILE)
    global read_file_state = readInput()


    println(INPUT_MESS_CHOOSE_SAVE_FILTER)
    global save_file_state = readInput()

    println(INPUT_MESS_PHRASE_TO_SEARCH)
    global phrase_filter = readInput()

  
   
 
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

            #result = filter(x-> occursin("$phrase_filter", x), s)
            if contains("$s","$phrase_filter")
             insertToResultFileLog(result_file_path,s)
            end
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

    foreach(list_files_in_path(dir)) do f
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
    file_name = first(list_files_in_path(dir))
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
    file_name = last(list_files_in_path(dir))
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
    count_of_file = length(list_files_in_path(dir))
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

function closeFile(dir)
    file_path_result_log = dir * "/" *result_dir_name * "/" * result_file_name
    close(file_path_result_log)
end

function insertToResultFileLog(file,text)
    write(file,text)
end



function showFieldsState()
    message = "\n\n Configs: \n - state read file: $read_file_state \n - state save file: $save_file_state \n\n Start App -> \n\n"
    println(message)
end


main()








