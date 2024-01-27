import multiprocessing
import datetime

# raw string to preprocessed list of tokens
def preprocess_text(text: str):
    replace_with_space = ['\n', '/']
    for to_replace in replace_with_space:
        text = text.replace(to_replace, ' ')

    replace_with_nothing = ['"', "''", '.', '!', '?', '(', ')', '=', ';', ':', ',', "'s", '{', '}' '“', '“', '”', '‘', '’', '«', '»', '¨', '·', '£', '₤', '$', '#', '@', '§', '[', ']', "*", '~', '&', '^']
    for to_replace in replace_with_nothing:
        text = text.replace(to_replace, '')

    text = text.lower()
    text = text.split(" ")

    tokens = []
    for i in range(0, len(text)):
        stripped_token = text[i].strip().strip("'")
        if (stripped_token.isalpha()):
            tokens.append(stripped_token)
        
    return tokens

# Function to write a list of items to a text file
def write_list_to_file(items, filename):
    with open(filename, 'w', encoding='utf-8') as file:
        file.write("\n".join(items))

# Function to count word occurrences in a list of tokens
def count_word_occurrences(tokens):
    word_counts = {}
    for token in tokens:
        if token in word_counts:
            word_counts[token] += 1
        else:
            word_counts[token] = 1
    return word_counts

# Read the dataset file
def readFile(filename):
    with open(filename, 'r', encoding='utf-8') as file:
        dataset = file.read()

    return dataset

# Main function of the Program
def main():
    # Starts the time of processing
    start = datetime.datetime.now()
    print("START:", start)

    # Preprocess the text
    preprocessed = preprocess_text(readFile("movie_reviews_dataset.csv"))

    # Count word occurrences using multiprocessing
    with multiprocessing.Pool() as pool:
        word_counts = pool.map(count_word_occurrences, [preprocessed])

    # Combine word counts into a single dictionary
    combined_word_counts = {}
    for wc in word_counts:
        for token, count in wc.items():
            if token in combined_word_counts:
                combined_word_counts[token] += count
            else:
                combined_word_counts[token] = count

    # Sort the word occurrences in descending order
    sorted_word_counts = sorted(combined_word_counts.items(), key=lambda x: x[1], reverse=True)

    # Extract the top 100 word tokens
    top_100_tokens = [token for token, _ in sorted_word_counts[:100]]

    # Write the unique tokens to a file
    unique_tokens = list(set(preprocessed))
    write_list_to_file(unique_tokens, 'unique_tokens.txt')

    # Write the top 100 tokens to a file
    write_list_to_file(top_100_tokens, 'top_100_tokens.txt')

    print("Process completed successfully.")

    # Ends the time of processing
    end = datetime.datetime.now()
    print("END:", end)
    print("DURATION:", end - start)

if __name__ == "__main__":
    main()
