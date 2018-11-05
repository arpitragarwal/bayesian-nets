clear; clc; close all;

train_filename = 'data/lymph_train.arff.txt';
[train_data, meta] = read_arff_file(train_filename);
%train_data = train_data(42:46, :);

mutual_info_matrix = get_mutual_info_matrix(train_data, meta);
[vertex_indices, edges] = get_prims_mst(train_data, mutual_info_matrix);

%% for debugging
%edges = edges - ones(size(edges));

%% generate conditional probability tables
cond_prob_tables = get_conditional_probability_tables(train_data, meta, edges);