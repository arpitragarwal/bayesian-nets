function [predicted_class, probability] = TAN_classification(train_data, test_data, meta)

% Generate mutual info matrix and Maximum spanning tree
mutual_info_matrix = get_mutual_info_matrix(train_data, meta);
[vertex_indices, edges] = get_prims_mst(train_data, mutual_info_matrix);

% generate conditional probability tables
cond_prob_tables = get_conditional_probability_tables(train_data, meta, edges);

% predict labels
[predicted_class, probability] = get_tan_predictions(test_data, meta, cond_prob_tables, edges);
end