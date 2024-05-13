# Packages
using Plots
using Dates

using Pkg
#Pkg.add("Plots")
#Pkg.add("Plotly")
#Pkg.add("PlotlyBase")

# Constants
ERR_MESS_DIR_IS_EMPTY = "the directory is empty."
ERR_MESS_IS_NOT_DIR = "no such file or directory"
INFO_MESS_CREATE_FOLDER = "Result folder created successfully."
INPUT_MESS_DIRECTORY_PATH = "Enter directory path:"
INPUT_MESS_CHOOSE_READ_FILE = "Choose one of the following modes to read files: \n read all file in directory (0). \n read first file in directory (1). \n read last file in directory (2). \n Enter Number :"
INPUT_MESS_CHOOSE_SAVE_FILTER = "Choose one of the following modes to read files: \n save (0). \n does not save (1).  \n Enter Number :"
INPUT_MESS_PHRASE_TO_SEARCH = "Enter a phrase to search in the files:\n"

# Variables
result_dir_name = "result"
result_file_name = "result.log"
save_file_state = "-1"
read_file_state = "-1"
phrase_filter = " "
total_find:: Int32 = 0
total_line:: Int32 = 0
total_file:: Int32 = 0

# Main function
function main()
   #__init__()
  testTimae()
end

function testTimae()
  
# another vector in y-axis
z = rand(10)
 
# to plot on previous graph
plot!(z, linecolor =:red, 
          line =:dashdot, 
          labels = "Z")


          x = range(0, 10, length=100)
y = sin.(x)
p=plot(x, y)

savefig("myplot.png")      # saves the CURRENT_PLOT as a .png
savefig(p, "myplot.pdf")   # saves the plot from p as a .pdf vector graphic

end

# Initialize the application
function __init__()
    println(INPUT_MESS_DIRECTORY_PATH)
    dir_path = read_input()

    println(INPUT_MESS_CHOOSE_READ_FILE)
    global read_file_state = read_input()

    println(INPUT_MESS_CHOOSE_SAVE_FILTER)
    global save_file_state = read_input()

    println(INPUT_MESS_PHRASE_TO_SEARCH)
    global phrase_filter = read_input()
  
    if ! is_dir_has_file(dir_path)
        return
    end
 
    if save_file_state == "0"
        create_folder(dir_path)
        create_log_file(dir_path)
    end 

    show_fields_state()

    if read_file_state == "0"
        read_all_file(dir_path)
    elseif read_file_state == "1"
        read_first_file(dir_path)
    elseif read_file_state == "2"
        read_last_file(dir_path)
    end
end

# Display the current directory
function current_dir() 
    println("Current Directory: ", pwd())
    return pwd()
end

function list_files_in_path(path::String)
    # Get a list of all items (files and directories) in the path
    all_items = readdir(path)

    # Filter out directories to get only files
    files = filter(item -> isfile(joinpath(path, item)), all_items)

    return files
end

# Read a file with saving to the result log file
function read_file_with_save(filePath, result_file_path)
    println("file path : $filePath")

    open(filePath,"r") do f
        line = 0
        while ! eof(f)
            s = readline(f) 
            line += 1

             total_line += 1

            if contains("$s","$phrase_filter")
                total_find += 1
                insert_to_result_file_log(result_file_path, s)
            end
        end
    end
end

# Read a file without saving
function read_file_without_save(filePath)
    println("file path : $filePath")

    open(filePath,"r") do f
        line = 0
        while ! eof(f)
            s = readline(f) 
            line += 1
        end
    end
end

# List all files in a directory
function list_of_files_in_dir(dir)
    foreach(readdir(dir)) do f
        println("File name: ", f)
    end
end

# Read all files in a directory
function read_all_file(dir)
    file_path = ""
    if save_file_state == "0"
        op_result_log_file = open_file(dir)
    end

    foreach(list_files_in_path(dir)) do f
        total_file += 1
        file_path = dir * "/" * f

        if save_file_state == "0"
            read_file_with_save(file_path, op_result_log_file)
        else
            read_file_without_save(file_path)
       end
    end
end

# Read the first file in a directory
function read_first_file(dir)
    file_name = first(list_files_in_path(dir))
    file_path = dir * "/" * file_name

    if save_file_state == "0"
        op_result_log_file = open_file(dir)
    end

    total_file += 1

    if save_file_state == "0"
        read_file_with_save(file_path, op_result_log_file)
    else
        read_file_without_save(file_path)
   end
end

# Read the last file in a directory
function read_last_file(dir)
    file_name = last(list_files_in_path(dir))
    file_path = dir * "/" * file_name
   
    if save_file_state == "0"
        op_result_log_file = open_file(dir)
    end
    
    total_file += 1

    if save_file_state == "0"
        read_file_with_save(file_path, op_result_log_file)
    else
        read_file_without_save(file_path)
   end
end

# Check if a directory has files
function is_dir_has_file(dir)
    count_of_file = length(list_files_in_path(dir))
    if count_of_file > 0
        return true
    else
        println("Error: $ERR_MESS_DIR_IS_EMPTY")
        return false
    end
end

# Check if a directory exists
function is_exists_dir(dir)
    try
        readdir(dir)
        return true
    catch
        println("Error: $ERR_MESS_IS_NOT_DIR")
        return false
    end
end

# Check if a directory exists
function check_exist_dir(dir)
    try
        readdir(dir)
        return true
    catch
        return false
    end
end

# Create a folder
function create_folder(dir)
    path = dir * "/$result_dir_name" 
    if  is_exists_dir(dir)
        if ! check_exist_dir(path)
            mkdir(path) 
            println("Info: $INFO_MESS_CREATE_FOLDER")
        end
    end
end

# Create a log file
function create_log_file(dir)
    file =  dir * "/" * result_dir_name * "/" * result_file_name
    touch(file)
end

# Read user input
function read_input()
    return readline()
end

# Open the result log file
function open_file(dir)
    file_dir_path = dir * "/" * result_dir_name
    file_name = generate_name_for_result_log_file(file_dir_path)
    file_path_result_log = dir * "/" * result_dir_name * "/" * file_name
    return open(file_path_result_log,"a")
end

# Close the result log file
function close_file(dir)
    file_path_result_log = dir * "/" * result_dir_name * "/" * result_file_name
    close(file_path_result_log)
end

# Insert text to the result log file
function insert_to_result_file_log(file, text)
    write(file, text)
end

# Show the state of fields
function show_fields_state()
    message = "\n\n Configs: \n - state read file: $read_file_state \n - state save file: $save_file_state \n\n - phrase: $phrase_filter \n\n Start App -> \n\n"
    println(message)
end


function generate_name_for_result_log_file(dir)
    count:: Int32 = count_files(dir) 
    count +=1
 
    return result_file_name = string(Dates.today()) * "_" * string(count)
end

function  count_files(dir)
  return length(readdir(dir))
end

function get_date()
  return Dates.today()
end

function show_final_result()
    println("Result: \n\n total files: $total_file \n total line: $total_line \n total find: $total_find \n")
end

# Call the main function
main()

