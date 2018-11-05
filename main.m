clear; clc; close all; format compact;

train_filename = 'data/vote_train.arff.txt';
[train_data, meta] = read_arff_file(train_filename);
test_filename = 'data/vote_test.arff.txt';
[test_data, ~] = read_arff_file(test_filename);


[test_label_pred, probability] = naive_bayes_classification(train_data, test_data, meta);

%% evaluating accuracy
test_label_actual = test_data(:, end);
n_test_instances = size(test_data, 1);
n_correctly_classified = 0;
for i = 1:n_test_instances
    if(strcmp(test_label_actual{i}, test_label_pred{i}))
        n_correctly_classified = n_correctly_classified + 1;
    end
end
n_correctly_classified