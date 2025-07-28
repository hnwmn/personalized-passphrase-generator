# personalized-passphrase-generator

Traditional passwords can often be challenging to remember. With this tool, you can generate passphrases that resonate with your personal or professional life, making them easier to recall without sacrificing security. An ideal application of this tool would be using it to create a master password for a password manager like Bitwarden or KeePass.

The program is a bash shell script that works by extracting words from files of your choice and randomly generates a combination of them. You have the flexibility to work with various text file formats and even combine multiple files. Just separate the file paths with spaces if you choose to do so.

The script uses a 'stop_words.txt' file, which comes with a default list of common English language stop words to filter out commonly used words that aren't conducive to creating a secure and memorable passphrase. You may edit or customise this list to suit your preferences. 

## Run

Go to the project directory

```
 cd personalized-passphrase-generator
```

Make the script executable

```
 chmod +x personalized-passphrase-generator.sh
```

Run the script

```
 ./personalized-passphrase-generator.sh
```

## Usage

```
Enter the path to your file(s): sample.txt sample.csv
# of Words: 4
Generated passphrase: [xxxxx] [xxxxx] [xxxxx] [xxxxx]
Regenerate (r) or Exit (e): r
Generated passphrase: [xxxxx] [xxxxx] [xxxxx] [xxxxx]
Regenerate (r) or Exit (e): e
Goodbye!
```