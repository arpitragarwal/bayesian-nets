clear; clc; close all; format compact;

train_filename = 'data/vote_train.arff.txt';
[train_data, meta] = read_arff_file(train_filename);
test_filename = 'data/vote_test.arff.txt';
[test_data, ~] = read_arff_file(test_filename);


[predicted_label, probability] = naive_bayes_classification(train_data, test_data, meta);

%% evaluating accuracy
actual_label = test_data(:, end);
n_correctly_classified = get_num_of_correct_classifications(actual_label, predicted_label);