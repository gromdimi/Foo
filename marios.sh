#!/bin/bash
# get input file and input string
input_file=$1
input_string=$2

if [[ ! -f $input_file ]]; then
        echo "Error: Usernames file '$input_file' does not exist."
        exit 1
fi

if [[ -z $input_string ]]; then
        echo "Error: No string to search."
        exit 1
fi

# first extract the usernames from filenames.txt file
usernames=()

while IFS= read -r line; do
        usernames+=("$line")
done < $input_file


# echo "${usernames[@]}"

# perform prints of whether the file exist, or not or we don't have access.
for user in "${usernames[@]}"; do
        echo $user
        echo "#########"
        # get users' home directory to search for the file
        home_dir=$(getent passwd "$user" | cut -d: -f6)

        file_path="$home_dir/$input_string"

        # checks if the home directory of the user exists and we have access
        if [[ ! -d $home_dir ]]; then
                echo "$input_string: Permission denied to access home dir"
        # checks if the file exists
        elif [[ ! -e $file_path ]]; then
                echo "$input_string: File not found."
        # checks if we have read rights to the file
        elif [[ ! -r $file_path ]]; then
                echo "$input_string: Permission denied."
        # if all the above are false the file exists and we do have access.
        else
                file_size=$(stat -c%s "$file_path")
                echo "$input_string: File found, size $file_size bytes."
        fi
        echo ""
done