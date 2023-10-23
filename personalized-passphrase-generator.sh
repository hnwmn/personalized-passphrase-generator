#!/bin/bash

extract_words() {
   cat "${input_files_array[@]}" | grep -oE '\b[[:alpha:]]+\b' | awk '!seen[$0]++' > "$output_file"
}

stopwords_file="stop_words.txt"

generate_passphrase() {
   words_to_generate=$word_count
   generated_count=0
   generated_line="Generated passphrase: "
   while [ "$generated_count" -lt "$words_to_generate" ]; do
       word=$(shuf --random-source=/dev/urandom "$output_file" | head -n1)
      if ! grep -qw "$(echo "$word" | LC_ALL=C tr '[:upper:]' '[:lower:]')" < <(LC_ALL=C tr '[:upper:]' '[:lower:]' < "$stopwords_file"); then
           generated_line="$generated_line$word "
           ((words_to_generate--))
       fi
   done
   echo "$generated_line"
}

delete_output_file() {
   rm -f "$output_file"
}

if [ ! -f "$stopwords_file" ]; then
   echo "Stop words file not found: $stopwords_file"
   exit 1
fi

read -p "Enter the path to your file(s): " input_files

IFS=" " read -r -a input_files_array <<< "$input_files"

for input_file in "${input_files_array[@]}"; do
    if [ ! -f "$input_file" ]; then
        echo "File not found: $input_file"
        exit 1
    fi
done

while true; do
    read -p "# of Words: " word_count
    if [[ $word_count =~ ^[0-9]+$ ]]; then
        if ((word_count >= 4 && word_count <= 20)); then
            break
        else
            echo "Please enter an integer between 4 and 20."
        fi
    else
        echo "Invalid input. Please enter a valid integer."
    fi
done

output_file=$(mktemp)

extract_words

run=true

while true; do
  if [ "$run" = true ]; then
       generate_passphrase
       run=false
    fi

   read -p "Regenerate (r) or Exit (e): " choice

   case "$choice" in
       [Rr]*)
           generate_passphrase
           ;;
       [Ee]*)
           delete_output_file
           echo "Goodbye!"
           exit 0
           ;;
       *)
           echo "Invalid choice. Please enter 'r' to regenerate or 'e' to exit."
           ;;
   esac
done