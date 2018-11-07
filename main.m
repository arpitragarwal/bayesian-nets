clear; clc; close all; format compact;

train_filename = 'data/lymph_train.arff.txt';
[train_data, meta] = read_arff_file(train_filename);
test_filename = 'data/lymph_test.arff.txt';
[test_data, ~] = read_arff_file(test_filename);

%%
%[predicted_class, probability] = naive_bayes_classification(train_data, test_data, meta);
[predicted_class, probability] = TAN_classification(train_data, test_data, meta);

%% evaluating accuracy
actual_class = test_data(:, end);
n_correctly_classified = get_num_of_correct_classifications(actual_class, predicted_class);

%% printing outputs
print_classifier_info(meta);
print_labels_and_probabilities(predicted_class, actual_class, probability, n_correctly_classified);