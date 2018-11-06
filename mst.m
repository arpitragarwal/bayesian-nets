clear; clc; close all;

train_filename = 'data/lymph_train.arff.txt';
[train_data, meta] = read_arff_file(train_filename);
test_filename = 'data/lymph_test.arff.txt';
[test_data, ~] = read_arff_file(test_filename);
%train_data = train_data(42:46, :);

mutual_info_matrix = get_mutual_info_matrix(train_data, meta);
[vertex_indices, edges] = get_prims_mst(train_data, mutual_info_matrix);

%% for debugging
%edges = edges - ones(size(edges));

%% generate conditional probability tables
cond_prob_tables = get_conditional_probability_tables(train_data, meta, edges);

%% predict labels
[predicted_label, prob] = get_tan_predictions(test_data, meta, cond_prob_tables, edges);

actual_label = test_data(:, end);
n_correctly_classified = get_num_of_correct_classifications(actual_label, predicted_label);