#!/bin/bash
#trexei me tin entoli ./quiz-3.sh usernames.txt "tarball.tar.gz"

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <usernames_file> <filename_to_search>"
    exit 1
fi

usernames_file=$1
file_to_find=$2

if [ ! -f "$usernames_file" ]; then
    echo "Usernames file '$usernames_file' not found"
    exit 1
fi

if [ ! -s "$usernames_file" ]; then
    echo "Usernames file '$usernames_file' is empty"
    exit 1
fi

while IFS= read -r user; do
    home_dir="/home/$user"

    if [ ! -d "$home_dir" ]; then
        echo "$user: Home directory does not exist"
        continue
    elif [ ! -x "$home_dir" ]; then
        echo "$user: Permission denied to access home directory"
        continue
    fi

    target_file="$home_dir/$file_to_find"

    if [ ! -e "$target_file" ]; then
        echo "$user: File '$file_to_find' not found"
    elif [ ! -r "$target_file" ]; then
        echo "$user: Permission denied to read '$file_to_find'"
    else
        file_size=$(stat -c%s "$target_file" 2>/dev/null)
        if [ $? -eq 0 ]; then
            echo "$user: File '$file_to_find' found, size $file_size bytes"
        else
            echo "$user: Error retrieving size for '$file_to_find'"
        fi
    fi
done < "$usernames_file"
