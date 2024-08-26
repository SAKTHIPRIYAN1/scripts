#!/bin/bash

# Step 1: Get the radio button selection using zenity --list
option=$(zenity --list \
    --title="Choose Option" \
    --text="Select an option:" \
    --radiolist \
    --column="Select" --column="Option" \
    TRUE "Dir" FALSE "File" \
    --width=500 --height=300)

# Check if an option was selected
if [ $? -eq 1 ]; then
    echo "No option selected"
    exit 1
fi

# Step 2: Get the text input using zenity --entry
input_text=$(zenity --entry \
    --title="Input Required" \
    --text="Enter your text:" \
    --width=500 --height=100)

# Check if text was entered
if [ $? -eq 1 ]; then
    echo "No text input provided"
    exit 1
fi

# Step 3: Execute your script with the selected option and input text
if [ $option == "Dir" ]; then
	mkdir /mnt/programs/$input_text
	ln -s /mnt/programs/$input_text ~/Desktop/
	echo "dir created"
else
	vi /mnt/programs/$input_text
	echo "file created"
fi
