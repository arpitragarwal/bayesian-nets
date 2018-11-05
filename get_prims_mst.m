function [vertex_indices, edges] = get_prims_mst(train_data, mutual_info_matrix)
%UNTITLED Summary of this function goes here
% begin with a random node in node collection
% find max weight edge going out of collection
% add node to collection

n_attributes = size(train_data, 2) - 1;
%vertex_indices = [ceil(n_attributes * rand)];
vertex_indices = [1]; % choose first variable in input file as starting node
edges = [];
for i = 1:n_attributes - 1
    max_weight = 0;
    clearvars edge_idx_1 edge_idx_2
    for j = 1:length(vertex_indices)
        [sorted_weights, sorted_idx] = sort(mutual_info_matrix(vertex_indices(j), :), 'descend');
        for k = 1:n_attributes
            weight_jk = sorted_weights(k);
            idx_jk = sorted_idx(k);
            if(weight_jk > max_weight && ~ismember(idx_jk, vertex_indices))
                max_weight = weight_jk;
                edge_idx_1 = vertex_indices(j);
                edge_idx_2 = idx_jk;
            end
        end
    end
    vertex_indices = [vertex_indices; edge_idx_2];
    edges = [edges; edge_idx_1, edge_idx_2];
end
end

